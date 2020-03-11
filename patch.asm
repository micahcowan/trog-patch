;; Patches trog.nes, the "Trog" game for NES (USA), so that the ROM
;; can be played with two players on a Famicom by using
;; the player two "A" button in place of (the nonexistant) "Start"

*= $1E894	and #$90
