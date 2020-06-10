; this empty segment is placed at the end of the executable.
; it is used by the hacked crt to determine how large the image is
endseg segment byte public 'ENDSEG' use16
endseg ends

_TEXT segment byte public 'CODE' use16
_TEXT ends

extrn stuntsmain:proc
