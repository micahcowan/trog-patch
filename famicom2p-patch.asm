;; Patches trog.nes, the "Trog" game for NES (USA), so that the ROM
;; can be played with two players on a Famicom by using
;; the player two "A" button in place of (the nonexistant) "Start"

; Original ROM location is $1E894.
; We need to add 16 ($10) to that for the iNES header.
*= $1E8A4	and #$90
