extends Node

var key_locations: Dictionary = {
	"49" = Vector2(0, 0), #KEY_1 - 1
	"50" = Vector2(1, 0), #KEY_2 - 2
	"51" = Vector2(2, 0), #KEY_3 - 3
	"52" = Vector2(3, 0), #KEY_4 - 4
	"53" = Vector2(4, 0), #KEY_5 - 5
	"54" = Vector2(5, 0), #KEY_6 - 6
	"55" = Vector2(6, 0), #KEY_7 - 7
	"56" = Vector2(7, 0), #KEY_8 - 8
	"57" = Vector2(8, 0), #KEY_9 - 9
	"48" = Vector2(9, 0), #KEY_0 - 0
	
	"81" = Vector2(0, 1), #KEY_Q - Q
	"87" = Vector2(1, 1), #KEY_W - W
	"69" = Vector2(2, 1), #KEY_E - E
	"82" = Vector2(3, 1), #KEY_R - R
	"84" = Vector2(4, 1), #KEY_T - T
	"89" = Vector2(5, 1), #KEY_Y - Y
	"85" = Vector2(6, 1), #KEY_U - U
	"73" = Vector2(7, 1), #KEY_I - I
	"79" = Vector2(8, 1), #KEY_O - O
	"80" = Vector2(9, 1), #KEY_P - P
	
	"65" = Vector2(0, 2), #KEY_A - A
	"83" = Vector2(1, 2), #KEY_S - S
	"68" = Vector2(2, 2), #KEY_D - D
	"70" = Vector2(3, 2), #KEY_F - F
	"71" = Vector2(4, 2), #KEY_G - G
	"72" = Vector2(5, 2), #KEY_H - H
	"74" = Vector2(6, 2), #KEY_J - J
	"75" = Vector2(7, 2), #KEY_K - K
	"76" = Vector2(8, 2), #KEY_L - L
	"59" = Vector2(9, 2), #KEY_SEMICOLON - ;
	
	"90" = Vector2(0, 3), #KEY_Z - Z
	"88" = Vector2(1, 3), #KEY_X - X
	"67" = Vector2(2, 3), #KEY_C - C
	"86" = Vector2(3, 3), #KEY_V - V
	"66" = Vector2(4, 3), #KEY_B - B
	"78" = Vector2(5, 3), #KEY_N - N
	"77" = Vector2(6, 3), #KEY_M - M
	"44" = Vector2(7, 3), #KEY_COMMA - ,
	"46" = Vector2(8, 3), #KEY_PERIOD - .
	"47" = Vector2(9, 3), #KEY_SLASH - /
}

func get_key_location(key: Key) -> Vector2:
	return key_locations.get(str(key), Vector2(-1, -1))
