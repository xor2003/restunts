; this file's compiled counterpart must be placed first in the list of input
; files sent to tlink. tlink orders the segments in the order they are seen.
; the following order ensures reversed and patched code, data and stack for the
; original game is placed first in the executable image, followed by our ported
; code.

seg000 segment byte private 'STUNTSC' use16
seg000 ends

seg038 segment byte private 'STUNTSD' use16
seg038 ends

dseg segment byte private 'STUNTSD' use16
dseg ends

seg041 segment byte private 'STACK' use16
seg041 ends

_DATA segment byte private 'DATA' use16
_DATA ends

_BSS segment byte private 'BSS' use16
_BSS ends

SEG000_TEXT segment byte private 'CODE' use16
SEG000_TEXT ends

; this empty segment is placed at the end of the executable.
; it is used by the hacked crt to determine how large the image is
endseg segment byte private 'ENDSEG' use16
endseg ends

end
