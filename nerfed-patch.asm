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

;;;
; no egg spawns
; no ledge falling
