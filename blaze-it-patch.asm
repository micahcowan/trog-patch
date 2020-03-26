;; Blaze it
;;
;; In which our hero is always running at top speed
;; (and thus there is no need for mushrooms or speed weeds),
;; But the trogs are also running faster than ever.

;; All "* = " offsets are into the NES ROM file itself, and are thus $10
;; greater than the actual ROM location

#define TROG_SPEED  #$16
#define TROG_CHASE  #$18

; Ignore level-based speed lookups, and always use set values for trog
; speeds
;
; original:
;	$B1B4  B9 DA B1:    lda _data_171DA_indexed,y			/* A$171DA,y<171B4>X(FF)<1C488>Y(??)MAP[0A:(0A),0B:(0B),0E:[0E],0F:[0F],mmc:(un)]s(0)Z?S?*/
;	$B1B7  8D 75 06:    sta enemyBaseSpeedThisLevel			/* A$171DA,y<171B4>X(FF)<1C488>Y(??)MAP[0A:(0A),0B:(0B),0E:[0E],0F:[0F],mmc:(un)]s(0)Z?S?*/
;	$B1BA  B9 F3 B1:    lda _data_171F3_indexed,y			/* A$171F3,y<171BA>X(FF)<1C488>Y(??)MAP[0A:(0A),0B:(0B),0E:[0E],0F:[0F],mmc:(un)]s(0)Z?S?*/
;	$B1BD  8D 76 06:    sta enemyChaseSpeedThisLevel			/* A$171F3,y<171BA>X(FF)<1C488>Y(??)MAP[0A:(0A),0B:(0B),0E:[0E],0F:[0F],mmc:(un)]s(0)Z?S?*/

* = $171C4
	; orig: lda from indexed data, y
	lda TROG_SPEED
	nop			; [lda imm] is one byte shorter than [lda ,y]

* = $171CA
	; orig: lda from indexed data, y
	lda TROG_CHASE
	nop			; [lda imm] is one byte shorter than [lda ,y]



; Start player at their max speed
; original: lda #$03
* = $171A0
	lda #$06



; Disable mushroom and speed weed spawns
;  At this location there's a lookup table for spawnable items.
;  I don't completely understand the logic that leads to which one is
;  chosen, but they correspond to "mushroom", "speed weed", and "tar pit".
;  if I set the first two to $00, mushroo,s and speed weed never
;  get spawned.
;
;  However, this doesn't actually prevent speed weeds in bonus waves,
;  where they don't spawn in with the same timed-in mechanism.
* = $1486A	; Remember, real location is $1485A
	; orig: .byte $01,$02,$07
	.byt $00,$00,$07
