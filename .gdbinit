set $64BITS = 1
set verbose off
set breakpoint pending on

define ps32
    eval "p/s *(int32_t*)%p@4", &$arg0
end

define pu32
    eval "p/u *(uint32_t*)%p@4", &$arg0
end

define ps16
    eval "p/s *(int16_t*)%p@8", &$arg0
end

define pu16
    eval "p/u *(uint16_t*)%p@8", &$arg0
end

define ps8
    eval "p/s *(int8_t*)%p@16", &$arg0
end

define pu8
    eval "p/u *(uint8_t*)%p@16", &$arg0
end
