#ifndef RESTUNTS_KEYBOARD_H
#define RESTUNTS_KEYBOARD_H

void kb_init_interrupt(void);
void kb_exit_handler(void);
void interrupt kb_int9_handler(void);
void interrupt kb_int16_handler(unsigned bp, unsigned di, unsigned si,
                                unsigned ds, unsigned es, unsigned dx,
                                unsigned cx, unsigned bx, unsigned ax,
                                unsigned ip, unsigned cs, unsigned flags);
int kb_get_key_state(int key);
int kb_call_readchar_callback(void);
int kb_read_char(void);
int kb_checking(void);
void flush_stdin(void);
int kb_check(void);

#endif