"""Generate Case Study 01 figures and tables from explicitly simulated data.

Run: python docs/case-study-01/generate.py
Requires matplotlib. PNG previews are written to the OS temporary directory.
The original Strategy.md and its existing assets are never modified here.
"""
import csv
import hashlib
import json
import re
import tempfile
from datetime import datetime, timedelta
from pathlib import Path

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle, FancyBboxPatch
from matplotlib.ticker import FuncFormatter

BASE = Path(__file__).resolve().parent
D = json.loads((BASE / 'data.json').read_text(encoding='utf-8'))
OUT = BASE.parent / 'images' / 'case-study-01'
PREVIEW = Path(tempfile.gettempdir()) / 'mt5-case-study-01-preview'
OUT.mkdir(parents=True, exist_ok=True)
PREVIEW.mkdir(parents=True, exist_ok=True)
NAVY, GREEN, RED, BLUE, GOLD = '#15334c', '#16806a', '#c44949', '#3276b5', '#b97714'
plt.rcParams.update({'font.family': 'DejaVu Sans', 'font.size': 11,
                     'svg.fonttype': 'none', 'svg.hashsalt': 'case-study-01',
                     'axes.spines.top': False, 'axes.spines.right': False,
                     'axes.titleweight': 'bold', 'text.color': NAVY,
                     'axes.labelcolor': NAVY, 'figure.facecolor': 'white'})
rows = D['five_minute']
manifest = []


def aggregate(seq, label):
    return [label, seq[0][1], max(r[2] for r in seq), min(r[3] for r in seq),
            seq[-1][4], sum(r[5] for r in seq), sum(r[6] for r in seq)]


def validate():
    for seq in [rows, D['one_minute'], *D['branches'].values()]:
        for r in seq:
            assert r[3] <= min(r[1], r[4]) <= max(r[1], r[4]) <= r[2], r
            assert all(abs(v / D['tick'] - round(v / D['tick'])) < 1e-8 for v in r[1:5]), r
            assert r[5] >= abs(r[6]) and (r[5] + r[6]) % 2 == 0, r
    for seq,minutes in [(rows,5),(D['one_minute'],1)]:
        for before,after in zip(seq,seq[1:]):
            assert datetime.strptime(after[0],'%H:%M')-datetime.strptime(before[0],'%H:%M') == timedelta(minutes=minutes)
            assert before[4] == after[1], (before,after)
    for r in D['hourly_context']:
        assert r[3] <= min(r[1],r[4]) <= max(r[1],r[4]) <= r[2], r
        assert all(v/D['tick'] == round(v/D['tick']) for v in r[1:]), r
    assert D['hourly_context'][-1][4] == rows[0][1]
    assert aggregate(D['one_minute'], '09:55') == next(r for r in rows if r[0] == '09:55')
    assert sum(x[2] for x in D['profile']) == 100000
    assert sum(x[2] for x in D['profile'] if 20036 <= x[0] < 20072) == 70000
    ab = D['absorption_0940']
    assert sum(r[1] + r[2] for r in ab) == 34000
    assert sum(r[2] - r[1] for r in ab) == -10000
    for key, t in [('footprint_0945','09:45'),('footprint_0950','09:50'),('footprint_0955','09:55')]:
        r = next(r for r in rows if r[0] == t)
        assert all(r[3] <= x[0] <= r[2] for x in D[key])
        assert sum(x[1] for x in D[key]) <= (r[5] - r[6]) / 2
        assert sum(x[2] for x in D[key]) <= (r[5] + r[6]) / 2
    assert [r[1] for r in D['stops']] == sorted(r[1] for r in D['stops'])
    for i, (t, stop) in enumerate(D['stops']):
        if i:
            prior = next(r for r in rows if r[0] == D['stops'][i-1][0])
            assert stop == prior[3] - .25
        current = next(r for r in rows if r[0] == t)
        if t < '10:20':
            assert current[3] > stop
    assert D['exit'] == D['stops'][-1][1] - D['stop_slippage_points']
    exit_bar=next(r for r in rows if r[0]=='10:20')
    tape=D['exit_ticks']
    assert aggregate([[t,p,p,p,p,0,0] for t,p in tape],'10:20')[1:5] == exit_bar[1:5]
    assert [t for t,_ in tape] == sorted(t for t,_ in tape)
    assert all(p>D['stops'][-1][1] for t,p in tape if t<'10:21:19')
    assert next(p for t,p in tape if t==D['exit_time']) == D['exit']
    for group,bar_time in [('first_low_tests','09:40'),('good_loss_branch','10:00')]:
        bar=(D['branches']['good_loss'][0] if group=='good_loss_branch'
             else next(r for r in rows if r[0]==bar_time))
        assert all(bar[3]<=p<=bar[2] for _,p in D['selected_events'][group])
    assert (D['entry'] - D['initial_stop']) * 2 == 29
    assert (D['exit'] - D['entry']) * 2 - D['fees_round_trip_usd'] == 47
    assert 20014 > D['swing_high'] - .886 * (D['swing_high'] - D['swing_low'])


def save(fig, name, cutoff, caption):
    fig.savefig(OUT / f'{name}.svg', metadata={'Date': None}, bbox_inches='tight')
    fig.savefig(PREVIEW / f'{name}.png', dpi=125, bbox_inches='tight')
    plt.close(fig)
    p = OUT / f'{name}.svg'
    s = p.read_text(encoding='utf-8')
    s = re.sub(r'<!--.*?-->', '', s, flags=re.S)
    s = re.sub(r'>\s+<', '><', s)
    p.write_text(s, encoding='utf-8')
    manifest.append({'file': p.name, 'information_cutoff': cutoff, 'caption': caption})


def frame(title, subtitle='', figsize=(11.8, 5.8)):
    fig, ax = plt.subplots(figsize=figsize, layout='constrained')
    fig.suptitle(title, fontsize=16, fontweight='bold', color=NAVY)
    ax.set_title(subtitle, fontsize=10, fontweight='normal', pad=14)
    return fig, ax


def candles(ax, seq, full_price=False):
    for i, r in enumerate(seq):
        _, o, h, l, c = r[:5]
        color = GREEN if c >= o else RED
        ax.vlines(i, l, h, color=color, linewidth=1.5)
        ax.add_patch(Rectangle((i-.28, min(o,c)), .56, max(abs(c-o), .12),
                               facecolor=color, edgecolor=color))
    step = max(1, len(seq)//12)
    ticks = list(range(0,len(seq),step))
    ax.set_xticks(ticks, [seq[i][0] for i in ticks], rotation=35, ha='right')
    ax.set_xlim(-.8,len(seq)-.2)
    ax.set_ylim(min(r[3] for r in seq)-2,max(r[2] for r in seq)+3)
    ax.yaxis.set_major_formatter(FuncFormatter(lambda x,_: f'{x:,.2f}'))
    ax.set_ylabel('MNQ price (index points)')
    ax.set_xlabel('Candle start, EDT (UTC-04:00); simulated')
    ax.grid(axis='y', alpha=.17)


def line(ax, price, label, color=BLUE):
    ax.axhline(price, color=color, linestyle='--', linewidth=1, label=f'{label}: {price:,.2f}')


def chart(name, end, title, start='09:30', levels=(), volume=False):
    seq = [r for r in rows if start <= r[0] < end]
    assert all(datetime.strptime(r[0],'%H:%M')+timedelta(minutes=5) <= datetime.strptime(end,'%H:%M') for r in seq)
    if volume:
        fig, axs = plt.subplots(2,1,figsize=(11.8,7),height_ratios=[3,1],layout='constrained')
        ax=axs[0]
        fig.suptitle(title, fontsize=16, fontweight='bold')
        ax.set_title(f'Known at {end} EDT; completed 5-minute candles only', fontsize=10)
        v=axs[1]
        v.bar(range(len(seq)),[r[5] for r in seq],color=[GREEN if r[6]>=0 else RED for r in seq])
        v.axhline(20000,color=GOLD,linestyle='--',label='Approx. 20,000 reference')
        v.set_xticks(range(len(seq)),[r[0] for r in seq],rotation=35,ha='right')
        v.set_ylabel('Contracts / 5 min')
        v.set_ylim(0,max(r[5] for r in seq)*1.4)
        v.legend(loc='upper right',fontsize=9)
    else:
        fig,ax=frame(title,f'Known at {end} EDT; completed 5-minute candles only')
    candles(ax,seq)
    for price,label,color in levels: line(ax,price,label,color)
    if levels:
        lower=min(min(r[3] for r in seq), min(p for p,_,_ in levels))-2
        upper=max(max(r[2] for r in seq), max(p for p,_,_ in levels))
        ax.set_ylim(lower,upper+max(3,(upper-lower)*.35))
        ax.legend(loc='upper right',fontsize=9,framealpha=.95)
    save(fig,name,end,title)


def cards(name,title,items,cutoff):
    fig,ax=frame(title,'Simulated case study; read left to right',figsize=(11.8,4.5))
    ax.set_xlim(0,len(items));ax.set_ylim(0,1);ax.axis('off')
    for i,(head,body,color) in enumerate(items):
        ax.add_patch(FancyBboxPatch((i+.04,.08),.9,.8,boxstyle='round,pad=.015',facecolor='#f4f8fb',edgecolor=color,linewidth=1.5))
        ax.text(i+.49,.78,head,ha='center',va='top',fontsize=12,fontweight='bold',color=color)
        ax.text(i+.49,.61,body,ha='center',va='top',fontsize=11,linespacing=1.65)
        if i<len(items)-1: ax.annotate('',xy=(i+1.03,.48),xytext=(i+.95,.48),arrowprops={'arrowstyle':'->','color':NAVY})
    save(fig,name,cutoff,title)


validate()
fifteen=[aggregate(rows[i:i+3],rows[i][0]) for i in range(0,len(rows),3)]
hourly=[aggregate(rows[i:i+12],rows[i][0]) for i in range(0,len(rows),12)]
for name,seq in [('five-minute',rows),('one-minute-confirmation',D['one_minute']),('fifteen-minute',fifteen),('hourly-session',hourly)]:
    with (BASE/f'{name}.csv').open('w',newline='',encoding='utf-8') as f:
        w=csv.writer(f);w.writerow(D['five_minute_columns']);w.writerows(seq)

cards('01-process','One session, one decision chain',[
    ('08:30-09:30','Prepare context\nMark location\nSet learning limits',BLUE),
    ('09:30-10:00','Wait for discount\nObserve two failures\nConfirm buyers',GOLD),
    ('10:00 onward','Execute one micro\nProtect the position\nRead effort vs result',GREEN),
    ('After the trade','Record actual fills\nGrade execution\nReplay decisions',NAVY)],'Plan, no outcome disclosed')

fig,ax=frame('Accepted value is moving higher','Known at 08:30 EDT; independent simulated completed-session profiles')
for i,(label,lo,hi,poc) in enumerate(D['value_history']):
    ax.add_patch(Rectangle((i-.32,lo),.64,hi-lo,facecolor='#d9e9f7',edgecolor=BLUE))
    ax.hlines(poc,i-.32,i+.32,color=NAVY,linewidth=3)
    ax.text(i,hi+5,f'{lo:,.0f}-{hi:,.0f}',ha='center',fontsize=10)
ax.set_xticks(range(4),[r[0].replace(', ','\n') for r in D['value_history']]);ax.set_xlim(-.6,3.6);ax.set_ylim(19890,20100)
ax.set_ylabel('Price; dark line = supplied POC');ax.grid(axis='y',alpha=.2)
save(fig,'02-value-history','08:30','Sideways previous-week value gives way to higher accepted prices.')

fig,axs=plt.subplots(2,1,figsize=(11.8,8),layout='constrained')
fig.suptitle('Higher-timeframe context, before execution',fontsize=16,fontweight='bold')
hist=D['hourly_context'][:-1]
candles(axs[0],[[r[0][5:],*r[1:]] for r in hist]);axs[0].set_title('Known at 08:40; 1-hour extracts completed by 08:00; date gaps',fontsize=11)
four=[]
for i in [0,4,8]:
    group=hist[i:i+4]
    four.append([group[0][0][5:],group[0][1],max(r[2] for r in group),min(r[3] for r in group),group[-1][4]])
candles(axs[1],four);axs[1].set_title('4-hour bars aggregated from each group of four hourly bars',fontsize=11)
save(fig,'03-higher-timeframes','08:40','Higher lows and a completed impulse provide context; the overnight block is balanced.')

fig,ax=frame('Location comes from the profile and the completed swing','Known before the open; prior 23 September session, 100,000 contracts')
for lo,hi,vol in D['profile']:
    ax.barh((lo+hi)/2,vol,height=(hi-lo)*.85,color=BLUE if 20036<=lo<20072 else '#cbd8e3')
ax.axhspan(20011.4,20029.5,color=GREEN,alpha=.14,label='Fib discount zone: 20,011.40-20,029.50')
for p,l,c in [(20036,'VAL',BLUE),(20072,'VAH',BLUE),(20044,'Exact tick POC',NAVY),(20021.2,'0.788',GREEN)]:line(ax,p,l,c)
ax.set_ylabel('MNQ price');ax.set_xlabel('Contracts in each price bin (bin widths vary)');ax.legend(fontsize=9)
save(fig,'04-profile-location','08:40','The Fib zone lies wholly below value; 20,012-20,024 is a low-volume bin.')

cards('05-gamma','Gamma changes the response to movement, not its direction',[
    ('Negative gamma','Price rises\nDealer hedge may buy\nMove may accelerate\n\nPrice falls\nDealer hedge may sell',RED),
    ('Positive gamma','Price rises\nDealer hedge may sell\nMove may dampen\n\nPrice falls\nDealer hedge may buy',BLUE),
    ('Today, 08:50','Supplied GEX: -120 units\nMapped put wall: 20,000\nMapped call wall: 20,055\nMapped flip: 20,080\n\nNone is an entry signal',NAVY)],'08:50')

chart('06-wait','09:40','A pullback reaches the planned location',start='09:00',levels=[(20029.5,'0.705',GREEN),(20021.2,'0.788',GREEN),(20011.4,'0.886',RED),(20036,'VAL',BLUE)],volume=True)
chart('07-absorption-candle','09:45','First seller failure: the candle is only the result',levels=[(20014,'First low',RED),(20011.4,'0.886',GOLD)])

fig,ax=frame('Inside the 09:40 candle: executed volume','Known at 09:45 EDT; grouped rows sum to 34,000 contracts, delta -10,000')
ab=D['absorption_0940'];ys=list(range(len(ab)))
ax.barh(ys,[-r[1] for r in ab],color=RED,label='Bid executions: aggressive sells')
ax.barh(ys,[r[2] for r in ab],color=GREEN,label='Ask executions: aggressive buys')
ax.set_yticks(ys,[r[0] for r in ab]);ax.set_xlabel('Executed contracts; left/right distinguish aggressor side')
for i,r in enumerate(ab):
    ax.text(-r[1]-200,i,f'{r[1]:,}',ha='right',va='center',fontsize=10)
    ax.text(r[2]+200,i,f'{r[2]:,}',ha='left',va='center',fontsize=10)
ax.set_xlim(-14500,7500);ax.legend(loc='lower right',fontsize=9)
save(fig,'08-absorption-profile','09:45','Heavy selling at the lower extreme is met by passive buying; this is not entry permission.')

chart('09-first-shift','09:50','Buyers respond, but the second test has not happened',start='09:40',levels=[(20014,'First failure',RED),(20025,'First rebound high',BLUE)])
chart('10-second-test','09:55','The second seller attempt stops higher',start='09:40',levels=[(20014,'First low',RED),(20018.25,'Second low',GOLD),(20025,'Rebound high still to clear',BLUE)])
chart('11-confirmation','10:00','Confirmation completes before the order is submitted',start='09:40',levels=[(20014,'First low',RED),(20018.25,'Higher second low',GOLD),(20025,'Broken rebound high',BLUE)])

fig,axs=plt.subplots(1,2,figsize=(11.8,5.5),layout='constrained')
fig.suptitle('The 09:55 confirmation candle, two views',fontsize=16,fontweight='bold')
candles(axs[0],D['one_minute']);axs[0].set_title('1-minute candles aggregate exactly to 5 minutes',fontsize=10)
axs[1].axis('off');fp=D['footprint_0955']
tbl=axs[1].table(cellText=[[f'{r[1]:,}',f'{r[0]:,.2f}',f'{r[2]:,}'] for r in reversed(fp)],colLabels=['Bid sells','Price','Ask buys'],loc='center',cellLoc='center')
tbl.auto_set_font_size(False);tbl.set_fontsize(12);tbl.scale(1,2)
axs[1].set_title('Selected exact ticks, known at 10:00 EDT',fontsize=10)
axs[1].text(.5,.12,'Diagonal ratios: 500/100 = 500%\n650/150 = 433%; 900/200 = 450%\nEach exceeds the illustrative 400% threshold.',ha='center',va='center',transform=axs[1].transAxes,fontsize=11)
save(fig,'12-footprint-and-one-minute','10:00','Positive imbalance supports the already completed two-failure sequence.')

fig,ax=frame('The order plan at 10:00','No later candles are shown; one MNQ contract')
candles(ax,[r for r in rows if '09:40'<=r[0]<'10:00'])
for p,l,c in [(D['entry'],'Actual buy fill',GREEN),(D['initial_stop'],'Protective stop trigger',RED),(D['target'],'Prior structural target',BLUE),(20036,'Reclaim value',GOLD)]:line(ax,p,l,c)
ax.set_ylim(20008,20066);ax.legend(fontsize=10,loc='upper left')
save(fig,'13-entry-risk','10:00','14.50 points to stop equals $29 price risk; stressed loss including costs is $31.')

chart('14-reclaim','10:05','Buyers reclaim the lower edge of value',start='09:50',levels=[(20036,'VAL',BLUE),(20028.25,'Entry',GREEN),(20027.5,'New stop, effective now',RED)],volume=True)
cards('15-participants','What might be behind the rally?',[
    ('Observable','10:00 candle\n36,000 contracts\nDelta +12,000\nClose 20,038\nValue reclaimed',BLUE),
    ('Possible short cover','Short from 20,014.50\nNow 23.50 points offside\n1 micro: -$47 gross\nBuying closes the short\nIdentity is not visible',RED),
    ('Possible hedging','Negative gamma context\nDealers may buy the rise\nOther buyers also exist\nNo identity in footprint\nInference, not proof',GOLD)],'10:05')

chart('16-management','10:15','Successful buying supports a structural trail',start='10:00',levels=[(20044,'Prior session POC',BLUE),(20050,'Round number',GOLD),(20042.75,'New stop, effective 10:15',RED)],volume=True)
chart('17-stall','10:20','More buyer effort, much less price progress',start='10:00',levels=[(20055,'Mapped call wall',GOLD),(20052.75,'New stop, effective 10:20',RED),(20060,'Unreached target',BLUE)],volume=True)

fig,ax=frame('Exit sequence: trigger and fill are different','Retrospective after 10:25 EDT; selected simulated prints, not a complete tape')
tt=D['exit_ticks'];ax.plot(range(len(tt)),[r[1] for r in tt],'-o',color=NAVY)
ax.set_xticks(range(len(tt)),[r[0] for r in tt],rotation=35,ha='right');ax.set_ylabel('MNQ traded price');ax.grid(alpha=.15)
ax.yaxis.set_major_formatter(FuncFormatter(lambda x,_: f'{x:,.2f}'))
ax.set_xlabel('Selected events, not uniform elapsed-time spacing')
line(ax,20052.75,'Stop trigger',RED);line(ax,20052.5,'Actual exit fill',GREEN);ax.legend(fontsize=10)
save(fig,'18-exit-tape','Retrospective 10:25','The stop triggers at 10:21:19; one tick of slippage gives a 20,052.50 fill.')

fig,ax=frame('Completed trade and stop history','Retrospective after exit; stop changes apply only from their stated times')
seq=[r for r in rows if '09:30'<=r[0]<'10:25'];candles(ax,seq)
positions={r[0]:i for i,r in enumerate(seq)}
exit_offset=(datetime.strptime(D['exit_time'],'%H:%M:%S')-datetime.strptime('10:20:00','%H:%M:%S')).total_seconds()/300
sx=[positions[t] for t,_ in D['stops']]+[positions['10:20']+exit_offset]
sy=[p for _,p in D['stops']]+[D['stops'][-1][1]]
ax.step(sx,sy,where='post',color=RED,linewidth=2,label='Active stop')
ax.scatter(positions['10:00'],D['entry'],s=75,color=GREEN,zorder=5,label='Buy 20,028.25')
ax.scatter(positions['10:20']+exit_offset,D['exit'],s=75,color=NAVY,zorder=5,label='Sell 20,052.50')
line(ax,20060,'Unreached target',BLUE);ax.legend(fontsize=9)
save(fig,'19-trade-review','Retrospective 10:25','One micro; gross profit $48.50, fees $1.50, net profit $47.00.')

chart('20-volume-fades','11:00','Participation fades and the session ends',start='10:25',volume=True)

fig,axs=plt.subplots(2,2,figsize=(11.8,8),layout='constrained')
fig.suptitle('Alternative branches, never part of the main trade record',fontsize=15,fontweight='bold')
for ax,(key,title,level) in zip(axs.flat,[('invalid_before_entry','A: 0.886 fails before confirmation',20011.4),('no_second_failure','B: second attempt makes a lower low',20014),('failed_reclaim','C: buyers cannot reclaim value',20036),('good_loss','D: valid entry, immediate stop-out',20013.75)]):
    r=D['branches'][key][0];candles(ax,[r],True);line(ax,level,'Decision level',RED)
    ax.set_title(title,fontsize=10);ax.legend(fontsize=8)
save(fig,'21-alternative-branches','Counterfactuals at their labelled stages','Four mutually exclusive continuations test the same decision rules.')

cards('22-discipline','Interrupt the behaviour before it becomes account damage',[
    ('Recognise','A loss is information\nUrgency is a warning\nA win can cause pride\nBreakevens can frustrate',BLUE),
    ('Act','No recovery trade\nNo increased size\nTwo losses: stop\n11:00: stop new entries',RED),
    ('Record','Save decision time\nSave available evidence\nGrade the process\nChoose one replay task',GREEN)],'Review and explicitly labelled branches')

cards('23-review-loop','The next repetition has a specific purpose',[
    ('Replay','Hide later candles\nPause at 09:45\nState why no entry\nAdvance one bar',BLUE),
    ('Measure','Rules followed?\nEntry, stop, costs\nNet R and drawdown\nKeep branches separate',GREEN),
    ('Adapt','Same process first\nCompare regimes\nNo strategy hopping\nNo profit guarantee',GOLD)],'After-session learning plan')

(BASE/'figures.json').write_text(json.dumps(manifest,indent=2)+'\n',encoding='utf-8')
report={'figures':len(manifest),'svg_bytes':sum(p.stat().st_size for p in OUT.glob('*.svg')),
        'data_sha256':hashlib.sha256((BASE/'data.json').read_bytes()).hexdigest(),
        'gross_risk':29,'stressed_risk_with_costs':31,'gross_profit':48.5,'net_profit':47,
        'net_R_price_risk':47/29,'net_R_stressed_risk':47/31,
        'validation':'Passed OHLC, tick, aggregation, volume, delta, stop chronology and P&L checks.'}
(BASE/'validation.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
print(json.dumps(report,indent=2))
