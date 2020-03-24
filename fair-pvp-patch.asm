;; Patches trog.nes, the "Trog" game for NES (USA), to give
;; player two a fighting chance in PvP. Without this patch,
;; player one wins handily each time.

#define DoPlayer $8025
#define playerOneFlags  $2C
#define playerTwoFlags  $2D
#define MEM(x) x - $10

; Here we replace a jump-start into player-handling (why is this there?)
; with a jump into our alternated player-handler address stored in mem.
*= $18010   ; orig is $18000
        jmp ($0100)

; This is near start of the Reset (starting) function.
; We're replacing some initialization code with a jump to another function where
; we do the bit of initialization we replaced, then also initialize our
; jump var for the player handlers below.
*= $1C083   ; orig is $1C073
        jsr MEM(ReplacedInit)

; Here we create two alternate versions of player handling - one that
; handles p1 first, then p2, and another that reverse. Both then toggle
; which gets called next.
;
; The idea is that, if one player is getting precedence over another for
; punches, then which player that is will at least alternate by frame.
        ;; Reverse player handling vs $18012
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

*= $1E710
MJCHandleThePlayersOne
        bit playerOneFlags
        bpl +
        ldx #$00
        jsr DoPlayer
+       bit playerTwoFlags
        bpl +
        ldx #$01
        jsr DoPlayer
+       lda #<MEM(MJCHandleThePlayersTwo)
        ldx #>MEM(MJCHandleThePlayersTwo)
        sta $0100
        stx $0101
        rts 

*= $1E915
MJCHandleThePlayersTwo
        bit playerTwoFlags
        bpl +
        ldx #$01
        jsr DoPlayer
+       bit playerOneFlags
        bpl +
        ldx #$00
        jsr DoPlayer
+       lda #<MEM(MJCHandleThePlayersOne)
        ldx #>MEM(MJCHandleThePlayersOne)
        sta $0100
        stx $0101
        rts 

ReplacedInit
        sta $8007   ; We replaced this op in order to jump here, so we
                    ; still have to do it
        lda #<MEM(MJCHandleThePlayersOne)
        ldx #>MEM(MJCHandleThePlayersOne)
        sta $0100
        stx $0101
        rts

* = $18F59
        ;; orig: cpx currentPlayerInfo
        nop
        nop
