(defparameter pglst NIL)
(defparameter pglstbk NIL)
(defun zyltmain()
; --------------------------------------------------------
(load "stdlib.ini")
; --------------------------------------------------------
(terpri)
)

; ========================================================
;[exe�����p]
(sb-ext:save-lisp-and-die "zyltmain.exe"      ; .exe ������iWindows �p�j
                          :toplevel #'zyltmain ; �g�b�v���x����main��
                          :executable t
                          :purify t)
; ========================================================
