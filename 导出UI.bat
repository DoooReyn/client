@echo off

rem ---- view ----
set outDir=res\view\plist\
set vidd=view/plist/fff
for /d %%i in (cocosstudio\view\*) do (
	if "%%~ni" EQU "login" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "createRole" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "chat" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "minimap" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "main" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "huntingBoss" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "goals" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "welfare" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "athletics" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "shop" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "roleEquip" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "roleInternal" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "roleNature" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "roleReincarnat" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "npcConvoy" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "pve" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "vip" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "payment" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "wing" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "walkthrough" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "worshipLord" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "pvp" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "eleBoss" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "title" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "beastSoul" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "giftBag" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "dayFirstRecharge" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "lucky" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "artifact" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "invest" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "hang" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "noble" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "skill" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "society" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "societyEx" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "firstPay" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "revelry" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "lottery" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "mount" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "mergeSvr" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "setting" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
	
	if "%%~ni" EQU "recycle" (
		call :publish %%i %outDir%%%~ni %%~ni 1
	)
)

set ext=Icon
for /d %%i in (cocosstudio\icon\*) do (
	if "%%~ni" EQU "title" (
		call :publish %%i %outDir%%%~ni%ext% %%~ni 3
	)
)

pause

:publish

set resPath=%1
set plistPath=%2.plist
set pvrPath=%2.pvr.ccz

rem tp path
set tool="TexturePacker.exe"

set param=--format cocos2d-x

rem replace path
set path1=view/%3/%3
if %4 EQU 3 (
	set path1=icon/%3/%3
)

set path2=%3/%3/
set param=%param% --replace %3=%path1%
set param=%param% --replace %path2%=

set param=%param% --data %plistPath%
set param=%param% --texture-format pvr3ccz
set param=%param% --sheet %pvrPath%
set param=%param% --alpha-handling PremultiplyAlpha

if %4 EQU 2 (
	set param=%param% --opt RGBA8888
) else (
	set param=%param% --opt RGBA4444
)

set param=%param% --dither-type FloydSteinbergAlpha
set param=%param% --max-size 2048
set param=%param% --size-constraints WordAligned
set param=%param% --scale 1
set param=%param% --algorithm MaxRects
set param=%param% --shape-padding 2
set param=%param% --border-padding 2
set param=%param% --enable-rotation
set param=%param% --trim-mode Trim
%tool% %param% %resPath%

goto :eof
exit