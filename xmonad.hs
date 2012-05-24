import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (doCenterFloat, isFullscreen, doFullFloat)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders   ( noBorders, smartBorders )
import XMonad.Layout.SimplestFloat
import System.IO

myNormalBorderColor = "#333333"
-- myFocusedBorderColor = "#4169e1"
myFocusedBorderColor = "#666666"

myLayouts = smartBorders $ avoidStruts ( tall ||| Mirror tall ||| Full ) ||| Full
     where
     -- default tiling algorithm partitions the screen into two panes
     tall   = Tall nmaster delta ratio
 
     -- The default number of windows in the master pane
     nmaster = 1
 
     -- Default proportion of screen occupied by master pane
     ratio   = 4/5
 
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100


myManageHook = composeAll
   [ (className =? "Firefox" <&&> resource =? "Dialog") --> doFloat
   ,  title =? "Downloads" --> doCenterFloat
   , className =? "Xmessage"  --> doFloat
   , className =? "Nautilus" --> doFloat
   , className =? "Gimp" --> doFloat
   , className =? "Add-ons" --> doFloat
   , className =? "Nautilus" --> doFloat
   , manageDocks
   ]


main = do
    xmproc <- spawnPipe "xmobar /home/gustavo/.xmobarrc"
    xmonad $ defaultConfig
        { manageHook = myManageHook <+> manageHook defaultConfig
        , layoutHook = myLayouts
	, terminal = "xterm -bg black -fg white"
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
			, ppCurrent = xmobarColor "#87cefa" ""
                        , ppTitle = xmobarColor "#87cefa" "" . shorten 100
                        }
        , normalBorderColor = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        }
	`additionalKeysP`
        [ 
	 ("M-p", spawn "dmenu_run -fn -*-profont-*-*-*-*-12-*-*-*-*-*-*-* -nb black -nf rgb:ff/ff/ff -sb rgb:00/a0/a0 -sf black")
	]


