;; Patches trog.nes, the "Trog" game for NES (USA), to give
;; player two a fighting chance in PvP. Without this patch,
;; player one wins handily each time.

#define DoPlayer $8025
#define playerOneFlags  $2C
#define playerTwoFlags  $2D
#define MEM(x) x - $10
#define mobOneLogicState $035A

; Here we replace a jump-start into player-handling (why is this there?)
; with a jump into our alternate player-handler address.
*= $18010   ; orig is $18000
        jmp MEM(MjcHandleThePlayers)

; This is near start of the Reset (starting) function.
; We're replacing some initialization code with a jump to another function where
; we do the bit of initialization we replaced, then also initialize our
; own new variables
*= $1C2AB   ; orig is $1C29B: sta $06AD
        jsr MEM(ReplacedInit)

; Here we create an alternate version of the player handling, that
; does additional processing after both players, delaying the punch
; check until both are processed.

        ;; Original:
        ;;
        ; bit playerOneFlags
        ; bpl +
        ; ldx #$00
        ; jsr DoPlayer
        ;+bit playerTwoFlags
        ; bpl +
        ; ldx #$01
        ; jmp DoPlayer
        ;+rts 

;; call out to after-the-fact punch
*= $1E710
MjcHandleThePlayers
        bit playerOneFlags
        bpl +
        ldx #$00
        jsr DoPlayer
+       bit playerTwoFlags
        bpl +
        ldx #$01
        jsr DoPlayer
+       jmp MEM(PostponedPunchProcessing)

*= $1E915
;; Process after-the-fact punching
PostponedPunchProcessing
        ldx #$01
-       lda $0100,x
        beq +
        sta mobOneLogicState,x
        lda #$00
        sta $0100,x
+       dex
        bpl -
        rts

;; Init after-the-fact punching
ReplacedInit
        sta $06AD   ; We replaced this op in order to jump here, so we
                    ; still have to do it
        lda #$00
        sta $0100
        sta $0101
        rts

;; replace immediate punching
* = $1901B
	;; prev: lda #$05
        sta $0100,x     ; Steals from stack, but s/b okay
	;; orig, same # bytes: jsr SetMobLogicStateToAccum

* = $18F59
        ;; orig: cpx currentPlayerInfo
        nop
        nop
