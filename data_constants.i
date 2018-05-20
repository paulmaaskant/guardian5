; constants

eRefreshStatusBar = %00000100
eUpdateStatusBar 	= %00010000
eUpdateTarget = 		%00100000
sysObjectSprites = %00000100

aMOVE = $00
aRANGED1 = $01
aRANGED2 = $02
aBRACE = $03
aCLOSECOMBAT = $04
aCHARGE = $05
aPIVOT = $06
aRUN = $07
aMARKTARGET = $08

aiBRACE = 0
aiCLOSECOMBAT = 5

AI_cooldown = 0
AI_move_defensive = 1
AI_move_offensive = 2
AI_ranged_attack_1 = 3
AI_ranged_attack_2 = 4
AI_close_combat = 5
AI_charge = 6

A = $10
B = $11
C = $12
D = $13
E = $14
F = $15
G = $16
H = $17
I = $18
J = $19
K = $1A
L = $1B
M = $1C
N = $1D
O = $1E
P = $1F
Q = $20
R = $21
S = $22
T = $23
U = $24
V = $25
W = $26
X = $27
Y = $28
Z = $29

lineBreak = $F1
nextPage = $F2
waitForA = $F3
endOfStream = $F4
setPortrait = $F5



comma = $0E
space = $0F
dash = $0B

enemy = #41

; get next byte OP codes
repeatBlank = $FF
repeatChar = $FE
setNumberValue = $FD
setDictionaryString = $FC
dict = $FC
parameter = $FD


; missionEvents

mEventOpenDialog = 0
mConditionRound = 1
mConditionOnlyFriendlies = 2
mConditionOnlyHostiles = 3
mEventEndMission = 4
