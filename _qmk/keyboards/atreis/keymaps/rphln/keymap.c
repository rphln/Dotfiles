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

enum {
  _BASE,
  _LOWER,
  _RAISE,
  _ADJUST,
};

enum {
  KC_ = KC_NO,
  KC_RST = RESET,

  KC_ADJ = MO(_ADJUST),
  KC_LOW = MO(_LOWER),
  KC_RAI = MO(_RAISE),

  KC_ARRW = DF(_LOWER),
  KC_BASE = DF(_BASE),
  KC_NMPD = DF(_RAISE),

  KC_INTO = SAFE_RANGE,
  KC_OOMK,
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    // clang-format off
    [_BASE] = LAYOUT_kc(
        // ╭──────┬──────┬──────┬──────┬──────┬──────╮           ╭──────┬──────┬──────┬──────┬──────┬──────╮
             ESC  , Q    , W    , F    , P    , B    ,             J    , L    , U    , Y    , QUOT , BSPC ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤           ├──────┼──────┼──────┼──────┼──────┼──────┤
             TAB  , A    , R    , S    , T    , G    ,             M    , N    , E    , I    , O    , ENT  ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤           ├──────┼──────┼──────┼──────┼──────┼──────┤
             LCPO , Z    , X    , C    , D    , V    ,             K    , H    , COMM , DOT  , SLSH , RCPC ,
        // ╰──────┴──────┴──────┴────┬─┴────┬─┴────┬─┴────╮ ╭────┴─┬────┴─┬────┴─┬────┴──────┴──────┴──────╯
                                       LWIN , LOW  , LSFT ,   SPC  , RAI  , LALT
        //                           ╰──────┴──────┴──────╯ ╰──────┴──────┴──────╯
        ),
    [_LOWER] = LAYOUT_kc(
        // ╭──────┬──────┬──────┬──────┬──────┬──────╮           ╭──────┬──────┬──────┬──────┬──────┬──────╮
             ADJ  , PGUP , HOME , UP   , END  , LCBR ,             RCBR , EQL  , TILD , PIPE , COLN , DEL  ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤           ├──────┼──────┼──────┼──────┼──────┼──────┤
             CAPS , PGDN , LEFT , DOWN , RGHT , LBRC ,             RBRC , UNDS , GRV  , BSLS , SCLN , INS  ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤           ├──────┼──────┼──────┼──────┼──────┼──────┤
             LCTL ,      ,      , PSCR , MPLY ,      ,                  , INTO ,      ,      ,      , RCTL ,
        // ╰──────┴──────┴──────┴────┬─┴────┬─┴────┬─┴────╮ ╭────┴─┬────┴─┬────┴─┬────┴──────┴──────┴──────╯
                                            , LOW  ,      ,   RSFT , LWIN , LALT
        //                           ╰──────┴──────┴──────╯ ╰──────┴──────┴──────╯
        ),
    [_RAISE] = LAYOUT_kc(
        // ╭──────┬──────┬──────┬──────┬──────┬──────╮           ╭──────┬──────┬──────┬──────┬──────┬──────╮
             F12  , F1   , F2   , F3   , F4   , F5   ,             F6   , F7   , F8   , F9   , F10  , F11  ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤           ├──────┼──────┼──────┼──────┼──────┼──────┤
             MINS , 1    , 2    , 3    , 4    , 5    ,             6    , 7    , 8    , 9    , 0    , PLUS ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤           ├──────┼──────┼──────┼──────┼──────┼──────┤
             LCTL , EXLM , AT   , HASH , DLR  , PERC ,             CIRC , AMPR , ASTR , LPRN , RPRN , RCTL ,
        // ╰──────┴──────┴──────┴────┬─┴────┬─┴────┬─┴────╮ ╭────┴─┬────┴─┬────┴─┬────┴──────┴──────┴──────╯
                                       LWIN , LALT , LSFT ,        , RAI  ,
        //                           ╰──────┴──────┴──────╯ ╰──────┴──────┴──────╯
        ),
    [_ADJUST] = LAYOUT_kc(
        // ╭──────┬──────┬──────┬──────┬──────┬──────╮           ╭──────┬──────┬──────┬──────┬──────┬──────╮
                  ,      ,      ,      ,      ,      ,                  ,      , VOLU ,      ,      , RST  ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤           ├──────┼──────┼──────┼──────┼──────┼──────┤
                  ,      ,      ,      ,      ,      ,                  , MPRV , VOLD , MNXT ,      , OOMK ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤           ├──────┼──────┼──────┼──────┼──────┼──────┤
             LCTL ,      ,      ,      ,      ,      ,                  , BASE , ARRW , NMPD ,      , RCTL ,
        // ╰──────┴──────┴──────┴────┬─┴────┬─┴────┬─┴────╮ ╭────┴─┬────┴─┬────┴─┬────┴──────┴──────┴──────╯
                                            ,      ,      ,        ,      ,
        //                           ╰──────┴──────┴──────╯ ╰──────┴──────┴──────╯
        ),
    // clang-format on
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  if (record->event.pressed) {
    if (keycode == KC_INTO)
      SEND_STRING("\n|> ");

    if (keycode == KC_OOMK)
      SEND_STRING(SS_LALT(SS_DOWN(X_PSCR) SS_TAP(X_F) SS_UP(X_PSCR)));
  }

  return true;
};
