#define MEM(x) (x - $10) 
; no enemies.
;  GAME GENIE CODE: ATVPTTXZ
* = $18013
        rts

; no spawn timed items (powerups, tar traps, etc)
;  GAME GENIE CODE: PXOKUSPE
* = $1CDAB
        and #$80

; no starting invincibility
;  GAME GENIE CODE: AEKEZAGP
* = $180D9
        lda #$00

;;; no game genie codes for below patches, though there are some with
;;; similar effects.

;; no egg spawns


* = $15346
    nop
    nop
    nop

* = $1536E
    nop
    nop
    nop

;; no ledge falling

* = $18E6A
    ;; beq +$08
    .byt $F0,$08

