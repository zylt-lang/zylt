(defparameter pglst NIL)
(defparameter pglstbk NIL)
(defun zyltmain()
; --------------------------------------------------------
(load "stdlib.ini")
; --------------------------------------------------------
(terpri)
)

; ========================================================
;[exe生成用]
(sb-ext:save-lisp-and-die "zyltmain.exe"      ; .exe をつける（Windows 用）
                          :toplevel #'zyltmain ; トップレベルをmainに
                          :executable t
                          :purify t)
; ========================================================
