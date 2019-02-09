; constants

typeNoHeat = #64

dTHE =50
dUNIT =32
dCONVOY = 49
dENEMY = 41
dCOMMANDER = 72
dMISSION_ACCOMPLISHED = 70
dTURRET= 48
dRANGE = 53
dMINUTES = 73
dDAMAGE = 15
dHEAT = 54

eRefreshStatusBar = %00000100
eCheckAction =      %00001000
eUpdateStatusBar 	= %00010000
eUpdateTarget = 		%00100000

sysObjectSprites = %00000100

aMOVE = $00
aJUMP = $01
aATTACK = $02
aBRACE = $03
aCLOSECOMBAT = $04
aCHARGE = $05
aPIVOT = $06
aRUN = $07
aMARKTARGET = $08

aiBRACE = 0
aiMOVE = 1
aiCLOSECOMBAT = 4

itemArmor = 4
itemFlamer = 5
itemActuator = 6


; test

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
emptyString = 0

; get next byte OP codes
  repeatBlank = $FF
  repeatChar = $FE
  setNumberValue = $FD
  setDictionaryString = $FC
  dict = $FC
  parameter = $FD
  targetName = $FB


; missionEvents
  mEventOpenDialog = 0
  mEventMissionAccomplished = 4
  mEventSpawnUnit = 5
  mEventPlaySound = 8
  mEventMissionFailed =9

  mConditionRound = 1
  mConditionOnlyFriendlies = 2
  mConditionOnlyHostiles = 3
  mConditionNodeReached = 6
  mConditionPilotCount = 7
