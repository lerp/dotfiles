set $64BITS = 1
set verbose off
set breakpoint pending on

define p32_128si
    eval "print *(int32_t*)%p@4", &$arg0
end

define p16_128si
    eval "print *(int16_t*)%p@8", &$arg0
end

define p8_128si
    eval "print *(int8_t*)%p@16", &$arg0
end
