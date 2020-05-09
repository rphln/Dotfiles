/* Copyright 2019 Raphael Nepomuceno
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include QMK_KEYBOARD_H

enum layer {
  _COLEMAK,
  _LOWER,
  _RAISE,
  _ADJUST,
};

enum custom_keycodes {
  KC_INTO = SAFE_RANGE,
  KC_OOMK,
};

#define KC_ (KC_NO)
#define KC__ (KC_TRNS)

#define KC_RST (RESET)

#define KC_ADJ (MO(_ADJUST))
#define KC_LOW (MO(_LOWER))
#define KC_RAI (MO(_RAISE))

#define KC_ARRW (DF(_LOWER))
#define KC_NMPD (DF(_RAISE))
#define KC_QWFP (DF(_COLEMAK))

// `KC_SYSREQ` doesn't work.
#define KC_SYSRQ (LALT(KC_PSCR))

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    // clang-format off
    [_COLEMAK] = LAYOUT_kc(
        // ╭──────┬──────┬──────┬──────┬──────┬──────╮             ╭──────┬──────┬──────┬──────┬──────┬──────╮
             TAB  , Q    , W    , F    , P    , B    ,               J    , L    , U    , Y    , QUOT , BSPC ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             ESC  , A    , R    , S    , T    , G    ,               M    , N    , E    , I    , O    , ENT  ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             LCPO , Z    , X    , C    , D    , V    ,               K    , H    , COMM , DOT  , SLSH , RCPC ,
        // ╰──────┴──────┴──────┴────┬─┴────┬─┴────┬─┴────╮   ╭────┴─┬────┴─┬────┴─┬────┴──────┴──────┴──────╯
                                       LWIN , LOW  , LSFT ,     SPC  , RAI  , LALT
        //                           ╰──────┴──────┴──────╯   ╰──────┴──────┴──────╯
        ),
    [_LOWER] = LAYOUT_kc(
        // ╭──────┬──────┬──────┬──────┬──────┬──────╮             ╭──────┬──────┬──────┬──────┬──────┬──────╮
             ADJ  , PGUP , HOME , UP   , END  , LCBR ,               RCBR , EQL  , TILD , PIPE , COLN , DEL  ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             CAPS , PGDN , LEFT , DOWN , RGHT , LBRC ,               RBRC , UNDS , GRV  , BSLS , SCLN , INS  ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             _    ,      ,      , PSCR , MPLY ,      ,                    , INTO ,      ,      ,      , _    ,
        // ╰──────┴──────┴──────┴────┬─┴────┬─┴────┬─┴────╮   ╭────┴─┬────┴─┬────┴─┬────┴──────┴──────┴──────╯
                                            , LOW  ,      ,     RSFT , LWIN , LALT
        //                           ╰──────┴──────┴──────╯   ╰──────┴──────┴──────╯
        ),
    [_RAISE] = LAYOUT_kc(
        // ╭──────┬──────┬──────┬──────┬──────┬──────╮             ╭──────┬──────┬──────┬──────┬──────┬──────╮
             F12  , F1   , F2   , F3   , F4   , F5   ,               F6   , F7   , F8   , F9   , F10  , F11  ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             MINS , 1    , 2    , 3    , 4    , 5    ,               6    , 7    , 8    , 9    , 0    , PLUS ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             _    , EXLM , AT   , HASH , DLR  , PERC ,               CIRC , AMPR , ASTR , LPRN , RPRN , _    ,
        // ╰──────┴──────┴──────┴────┬─┴────┬─┴────┬─┴────╮   ╭────┴─┬────┴─┬────┴─┬────┴──────┴──────┴──────╯
                                       LWIN , LALT , LSFT ,          , RAI  ,
        //                           ╰──────┴──────┴──────╯   ╰──────┴──────┴──────╯
        ),
    [_ADJUST] = LAYOUT_kc(
        // ╭──────┬──────┬──────┬──────┬──────┬──────╮             ╭──────┬──────┬──────┬──────┬──────┬──────╮
                  ,      ,      ,      ,      ,      ,                    ,      , VOLU ,      ,      , RST  ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
                  ,      ,      ,      ,      ,      ,                    , MPRV , VOLD , MNXT ,      , OOMK ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             _    ,      ,      ,      ,      ,      ,                    , QWFP , ARRW , NMPD ,      , _    ,
        // ╰──────┴──────┴──────┴────┬─┴────┬─┴────┬─┴────╮   ╭────┴─┬────┴─┬────┴─┬────┴──────┴──────┴──────╯
                                            ,      ,      ,          ,      ,
        //                           ╰──────┴──────┴──────╯   ╰──────┴──────┴──────╯
        ),
    // clang-format on
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
  case KC_INTO:
    if (record->event.pressed) {
      SEND_STRING("\n|> ");
    };

    break;

  case KC_OOMK:
    if (record->event.pressed) {
      register_code16(KC_SYSRQ);
      tap_code16(KC_F);
      unregister_code16(KC_SYSRQ);
    };

    break;
  };

  return true;
};
