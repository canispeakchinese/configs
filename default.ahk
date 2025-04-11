#Requires AutoHotkey v2.0
#SingleInstance force

;部分快捷键使用alt替换ctrl
!a::Send "^a"
!c::Send "^c"
!v::Send "^v"
!s::Send "^s"
;!f::Send "^f"
!z::Send "^z"
!w::Send "^w"
!r::Send "^r"

;该映射for vscode
;文件、命令搜索
!p::Send "^p"
!+p::Send "^+p"
;光标移动到终端以及第1、2、3个编辑器
CapsLock & m::Send "^m"
CapsLock & 0::Send "^0"
CapsLock & 1::Send "^1"
CapsLock & 2::Send "^2"
CapsLock & 3::Send "^3"
;光标往上下左右移动
CapsLock & h::Send "^h"
CapsLock & j::Send "^j"
CapsLock & k::Send "^k"
CapsLock & l::Send "^l"
;回到gd跳转之前的位置
CapsLock & o::Send "^o"
;历史命令搜索
CapsLock & r::Send "^r"
;终端往右移动一个单词
CapsLock & w::Send "!f" 

;该映射for终端
CapsLock & d::Send "^d"
CapsLock & u::Send "^u"
CapsLock & c::Send "^c"

;使用键盘快捷键操作光标移动
!h::Send "{Left}"
!j::Send "{Down}"
!k::Send "{Up}"
!l::Send "{Right}"

;使用大写锁定键实现部分终端命令&vim命令
SetCapsLockState "AlwaysOff"
CapsLock & a::Send "{Home}"
CapsLock & e::Send "{End}"
CapsLock::Send "{Esc}"