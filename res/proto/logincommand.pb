
�;
logincommand.protoPmd"�
Login"�
Param%
!AccountTokenVerifyLoginUserPmd_CS*
&AccountTokenVerifyReturnLoginUserPmd_S
ZoneInfoListLoginUserPmd_S"
UserLoginRequestLoginUserPmd_C%
!UserLoginReturnFailLoginUserPmd_S#
UserLoginReturnOkLoginUserPmd_S 
UserLoginTokenLoginUserPmd_C
ClientLogUrlLoginUserPmd_S
MessageBoxLoginUserPmd_S	(
$RequestAccountRegisterLoginUserPmd_C
'
#ReturnAccountRegisterLoginUserPmd_S!
UserLogoutTokenLoginUserPmd_C$
 UserLoginReconnectLoginUserPmd_C"
ReconnectKickoutLoginUserPmd_S
ServerKickoutLoginUserPmd_S%
!RequestZoneInfoListLoginUserPmd_C
SetServerLangLoginUserPmd_C!
RequestClientIPLoginUserPmd_C 
ReturnClientIPLoginUserPmd_S 
ReconnectErrorLoginUserPmd_S
CheckVersionLoginUserPmd_C#
PushAccountVerifyLoginUserPmd_C&
"BehaviorClientVerifyLoginUserPmd_C%
!RequestUserZoneInfoLoginUserPmd_C%
!RequestUserZoneInfoLoginUserPmd_S-
)MobileRegistRequestRandCodeLoginUserPmd_C,
(MobileRegistReturnRandCodeLoginUserPmd_S2
.MobileRegistRequestCreateAccountLoginUserPmd_C5
1MobileRegistReturnCreateAccountFailLoginUserPmd_S(
$RequestSupoortGameListLoginUserPmd_C'
#ReturnSupoortGameListLoginUserPmd_S0
,UserRequestPlatTokenByPasswordLoginUserPmd_C -
)UserRequestPlatTokenByThirdLoginUserPmd_C!-
)UserRequestPlatTokenLoginOkLoginUserPmd_S"/
+UserRequestPlatTokenLoginFailLoginUserPmd_S#1
-EmailRegistRequestCreateAccountLoginUserPmd_C$0
,EmailRegistReturnCreateAccountLoginUserPmd_S%&
"UserLoginReconnectOkLoginUserPmd_S&$
 GameServerShutDownLoginUserPmd_S'"
OnlineNumWaitingLoginUserPmd_S("�
!AccountTokenVerifyLoginUserPmd_CS
account (	
token (	
version (
gameid (
mid (	
platid (
zoneid (
gameversion (
compress	 (	
encrypt
 (	

encryptkey (	"�
PushAccountVerifyLoginUserPmd_C
accid (
account (	
zoneid (
token (	
version (
mid (	
gameversion (
compress (	
encrypt	 (	

encryptkey
 (	"`
&AccountTokenVerifyReturnLoginUserPmd_S(
retcode (2.Pmd.VerifyReturnReason
desc (	"�
ZoneInfo
zoneid (
zonename (	
state (2.Pmd.ZoneState
opentime (	
gameid (
iconurl (	
bitmask (
gamename (	
	newzoneid	 ("o
ZoneInfoListLoginUserPmd_S
gamename (	
gameid (
zonelist (2.Pmd.ZoneInfo
zoneid ("3
!RequestZoneInfoListLoginUserPmd_C
gameid ("3
!RequestUserZoneInfoLoginUserPmd_C
gameid ("T
UserZoneInfo
charname (	
zoneinfo (2.Pmd.ZoneInfo
	onlinenum ("L
!RequestUserZoneInfoLoginUserPmd_S'
userzoneinfo (2.Pmd.UserZoneInfo"N
)MobileRegistRequestRandCodeLoginUserPmd_C
	mobilenum (	
gameid ("Z
(MobileRegistReturnRandCodeLoginUserPmd_S
retcode (
desc (	
timeout ("�
.MobileRegistRequestCreateAccountLoginUserPmd_C
	mobilenum (	
randcode (	
password (	
gameid (
parent ("R
1MobileRegistReturnCreateAccountFailLoginUserPmd_S
retcode (
desc (	"�
-EmailRegistRequestCreateAccountLoginUserPmd_C
email (	
password (	
gameid (
isbind (
uid (
parent (
	mobilenum (	"Z
,EmailRegistReturnCreateAccountLoginUserPmd_S
retcode (
desc (	
uid ("q
,UserRequestPlatTokenByPasswordLoginUserPmd_C
gameid (
platid (
account (	
password (	"\
)UserRequestPlatTokenByThirdLoginUserPmd_C
platinfo (2.Pmd.PlatInfo
gameid ("�
)UserRequestPlatTokenLoginOkLoginUserPmd_S
uid (
platkey (	
	platlogin (	
platloginlife (
timezonename (	
timezoneoffset (
platinfo (2.Pmd.PlatInfo"L
+UserRequestPlatTokenLoginFailLoginUserPmd_S
retcode (
desc (	"b
UserLoginRequestLoginUserPmd_C
gameid (
zoneid (
gameversion (
mid (	"^
!UserLoginReturnFailLoginUserPmd_S+
retcode (2.Pmd.LoginReturnFailReason
desc (	"�
UserLoginReturnOkLoginUserPmd_S
	accountid (
logintempid (
tokenid (

gatewayurl (	
gameid (
zoneid (
separatezoneuid (
zoneuid (	
gatewayurltcp	 (	"�
UserLoginTokenLoginUserPmd_C
gameid (
zoneid (
	accountid (
logintempid (
	timestamp (
tokenmd5 (	
compress (	
encrypt	 (	

encryptkey
 (	
version (
compressmin (
lastseq (
charid ("�
 UserLoginReconnectLoginUserPmd_C
	accountid (
	timestamp (
tokenmd5 (	
logintempid (
gameid (
zoneid (
compress (	
encrypt	 (	

encryptkey
 (	
version (
compressmin (
lastseq (
charid ("P
ClientLogUrlLoginUserPmd_S
loglevel (	
logurl (	
distinct ("^
MessageBoxLoginUserPmd_S
btnleft (	
	btnmiddle (	
btnright (	
info (	"W
$RequestAccountRegisterLoginUserPmd_C
account (	
password (	
code (	"I
#ReturnAccountRegisterLoginUserPmd_S
account (	
	accountid ("
UserLogoutTokenLoginUserPmd_C".
ReconnectKickoutLoginUserPmd_S
desc (	",
ReconnectErrorLoginUserPmd_S
desc (	">
ServerKickoutLoginUserPmd_S
	accountid (
desc (	"�
PlatInfo
account (	
platid (2.Pmd.PlatType
email (	
gender (	
nickname (	
	timestamp (	
sign (	
faceurl
 (	
extdata (	
uid (	
imei (
osname (	"d
ThirdPlatLoginUserPmd_C
platinfo (2.Pmd.PlatInfo
gameid (
sid (	
uid (	"?
SetServerLangLoginUserPmd_C
lang (	

gameregion ("
RequestClientIPLoginUserPmd_C".
ReturnClientIPLoginUserPmd_S
pstrip (	"E
CheckVersionLoginUserPmd_C
default_charid (
version ("�
"BehaviorClientVerifyLoginUserPmd_C
account (	
token (	
version (
gameid (
mid (	
platid (
zoneid (
gameversion (
compress	 (	
encrypt
 (	

encryptkey (	"&
$RequestSupoortGameListLoginUserPmd_C"L
(ReturnSupoortGameListLoginUserPmd_S_Game
gamename (	
gameid ("f
#ReturnSupoortGameListLoginUserPmd_S?
gamelist (2-.Pmd.ReturnSupoortGameListLoginUserPmd_S_Game"3
"UserLoginReconnectOkLoginUserPmd_S
accid ("0
 GameServerShutDownLoginUserPmd_S
desc (	"W
OnlineNumWaitingLoginUserPmd_S

playingnum (

waitingnum (
mynum (*[
VerifyReturnReason
LoginOk 
TokenFindError
TokenDiffError
VersionError*?
	ZoneState
Shutdown 

Normal

Fullly
Starting*�
ZoneInfoBitMask
ZoneInfoBitMask_None 
ZoneInfoBitMask_Normal
ZoneInfoBitMask_SandBox
ZoneInfoBitMask_NoOpen*�
LoginReturnFailReason
Password
ServerShutdown
VersionTooLow
UserTokenFind
UserTokenTempId
UserTokenTimeOut
LoginDulicate
NoGatewaytDown
AccountUsing	
GatewayUserMax
*�
PlatType
PlatType_Normal 
PlatType_UC
PlatType_LeZhuanC
PlatType_WeChatD
PlatType_Play68E
PlatType_AiBeiF
PlatType_FacebookG
PlatType_GooglePlayH
PlatType_XingZhiZhuI
PlatType_HuoWuJ
PlatType_CaiGuoM
PlatType_1758O
PlatType_DAPAIP
PlatType_HILER
PlatType_AAYV
PlatType_WEIYOUZ
PlatType_9gc
PlatType_MOBILE�
PlatType_XueChi�
PlatType_Egret�
PlatType_AoXin�
PlatType_HUOSU�
PlatType_RONGQIANG�
PlatType_WXApp�
PlatType_RongQiangApp�