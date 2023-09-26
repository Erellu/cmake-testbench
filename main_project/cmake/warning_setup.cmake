#------------------------------------------------------------------------------
# Sets up the CMAKE_TESTBENCH_WARNING variable according to the current compiler.
########################################
#
# output: sets CMAKE_TESTBENCH_WARNING.
macro(cmake_testbench_setup_warning_list)
    if (MINGW OR CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set(CMAKE_TESTBENCH_WARNINGS
            -WNSObject-attribute
            -Waddress
            -Waddress-of-packed-member
            -Waggressive-loop-optimizations
            -Waligned-new
            -Wall
            -Walloc-zero
            -Walloca
            -Wanalyzer-double-fclose
            -Wanalyzer-double-free
            -Wanalyzer-exposure-through-output-file
            -Wanalyzer-file-leak
            -Wanalyzer-free-of-non-heap
            -Wanalyzer-malloc-leak
            -Wanalyzer-mismatching-deallocation
            -Wanalyzer-null-argument
            -Wanalyzer-null-dereference
            -Wanalyzer-possible-null-argument
            -Wanalyzer-possible-null-dereference
            -Wanalyzer-shift-count-negative
            -Wanalyzer-shift-count-overflow
            -Wanalyzer-stale-setjmp-buffer
            -Wanalyzer-tainted-array-index
            -Wanalyzer-too-complex
            -Wanalyzer-unsafe-call-within-signal-handler
            -Wanalyzer-use-after-free
            -Wanalyzer-use-of-pointer-in-stale-stack-frame
            -Wanalyzer-write-to-const
            -Wanalyzer-write-to-string-literal
            -Warith-conversion
            -Warray-bounds
            -Wattribute-warning
            -Wattributes
            -Wbool-compare
            -Wbool-operation
            -Wbuiltin-declaration-mismatch
            -Wbuiltin-macro-redefined
            -Wcannot-profile
            -Wcast-align
            -Wcast-align=strict
            -Wcast-function-type
            -Wcast-qual
            -Wchar-subscripts
            -Wclass-conversion
            -Wclass-memaccess
            -Wclobbered
            -Wcomma-subscript
            -Wcomment
            -Wconversion
            -Wconversion-null
            -Wcoverage-mismatch
            -Wcpp
            -Wctad-maybe-unsupported
            -Wctor-dtor-privacy
            -Wdangling-else
            -Wdate-time
            -Wdelete-incomplete
            -Wdelete-non-virtual-dtor
            -Wdeprecated
            -Wdeprecated-copy
            -Wdeprecated-copy-dtor
            -Wdeprecated-declarations
            -Wdeprecated-enum-enum-conversion
            -Wdeprecated-enum-float-conversion
            -Wdisabled-optimization
            -Wdiv-by-zero
            -Wdouble-promotion
            -Wduplicated-branches
            -Wduplicated-cond
            -Wempty-body
            -Wendif-labels
            -Wenum-compare
            -Wenum-conversion
            -Wexceptions
            -Wexpansion-to-defined
            -Wextra
            -Wextra-semi
            -Wfloat-conversion
            -Wfloat-equal
            -Wformat
            -Wformat-contains-nul
            -Wformat-diag
            -Wformat-extra-args
            -Wformat-nonliteral
            -Wformat-security
            -Wformat-signedness
            -Wformat-y2k
            -Wformat-zero-length
            -Wframe-address
            -Wfree-nonheap-object
            -Whsa
            -Wif-not-aligned
            -Wignored-attributes
            -Wignored-qualifiers
            -Winaccessible-base
            -Winherited-variadic-ctor
            -Winit-list-lifetime
            -Winit-self
            -Wint-in-bool-context
            -Wint-to-pointer-cast
            -Winvalid-memory-model
            -Winvalid-offsetof
            -Winvalid-pch
            -Wliteral-suffix
            -Wlogical-not-parentheses
            -Wlogical-op
            -Wlto-type-mismatch
            -Wmain
            -Wmaybe-uninitialized
            -Wmemset-elt-size
            -Wmemset-transposed-args
            -Wmisleading-indentation
            -Wmismatched-dealloc
            -Wmismatched-new-delete
            -Wmismatched-tags
            -Wmissing-attributes
            -Wmissing-field-initializers
            -Wmissing-include-dirs
            -Wmissing-profile
            -Wmultichar
            -Wmultistatement-macros
            -Wnarrowing
            -Wnoexcept
            -Wnoexcept-type
            -Wnon-template-friend
            -Wnon-virtual-dtor
            -Wnonnull
            -Wnonnull-compare
            -Wnull-dereference
            -Wodr
            -Wold-style-cast
            -Wopenmp-simd
            -Woverflow
            -Woverlength-strings
            -Woverloaded-virtual
            -Wpacked
            -Wpacked-bitfield-compat
            -Wpacked-not-aligned
            -Wparentheses
            -Wpedantic
            -Wpessimizing-move
            -Wplacement-new=1
            -Wpmf-conversions
            -Wpointer-arith
            -Wpointer-compare
            -Wpragmas
            -Wprio-ctor-dtor
            -Wpsabi
            -Wrange-loop-construct
            -Wredundant-decls
            -Wredundant-move
            -Wredundant-tags
            -Wregister
            -Wreorder
            -Wrestrict
            -Wreturn-local-addr
            -Wreturn-type
            -Wscalar-storage-order
            -Wsequence-point
            -Wshadow
            -Wshadow=compatible-local
            -Wshadow=local
            -Wshift-count-negative
            -Wshift-count-overflow
            -Wshift-negative-value
            -Wsign-compare
            -Wsign-conversion
            -Wsign-promo
            -Wsized-deallocation
            -Wsizeof-array-argument
            -Wsizeof-array-div
            -Wsizeof-pointer-div
            -Wsizeof-pointer-memaccess
            -Wstack-protector
            -Wstrict-null-sentinel
            -Wstring-compare
            -Wstringop-overread
            -Wstringop-truncation
            -Wsubobject-linkage
            -Wsuggest-attribute=cold
            -Wsuggest-attribute=const
            -Wsuggest-attribute=format
            -Wsuggest-attribute=malloc
            -Wsuggest-attribute=noreturn
            -Wsuggest-attribute=pure
            -Wsuggest-final-methods
            -Wsuggest-final-types
            -Wsuggest-override
            -Wswitch
            -Wswitch-bool
            -Wswitch-default
            -Wswitch-enum
            -Wswitch-outside-range
            -Wswitch-unreachable
            -Wsync-nand
            -Wtautological-compare
            -Wterminate
            -Wtrampolines
            -Wtrigraphs
            -Wtsan
            -Wtype-limits
            -Wundef
            -Wuninitialized
            -Wunknown-pragmas
            -Wunreachable-code
            -Wunsafe-loop-optimizations
            -Wunused
            -Wunused-but-set-parameter
            -Wunused-but-set-variable
            -Wunused-function
            -Wunused-label
            -Wunused-local-typedefs
            -Wunused-macros
            -Wunused-result
            -Wunused-value
            -Wunused-variable
            -Wuseless-cast
            -Wvarargs
            -Wvariadic-macros
            -Wvector-operation-performance
            -Wvexing-parse
            -Wvirtual-inheritance
            -Wvirtual-move-assign
            -Wvla
            -Wvla-parameter
            -Wvolatile
            -Wvolatile-register-var
            -Wwrite-strings
            -Wzero-as-null-pointer-constant
            -Wzero-length-bounds
        )
    elseif(MSVC)
        set(CMAKE_TESTBENCH_WARNINGS
            /Wall
            /wd4514 # Disabled - see below
            /wd4625 # Disabled - see below
            /wd4626 # Disabled - see below
            /wd4668 # Disabled - see below
            /wd4710 # Disabled - see below
            /wd4711 # Disabled - see below
            /wd4820 # Disabled - see below
            /wd5026 # Disabled - see below
            /wd5027 # Disabled - see below
            /wd5045 # Disabled - see below
            /wd5246 # Disabled - see below
        )
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        set(CMAKE_TESTBENCH_WARNINGS
            -WNSObject-attribute
            -Waddress
            -Waddress-of-packed-member
            -Wall
            -Walloca
            -Warray-bounds
            -Wattribute-warning
            -Wattributes
            -Wbool-operation
            -Wbuiltin-macro-redefined
            -Wcast-align
            -Wcast-function-type
            -Wcast-qual
            -Wchar-subscripts
            -Wclass-conversion
            -Wcomment
            -Wconversion
            -Wconversion-null
            -Wcpp
            -Wctad-maybe-unsupported
            -Wctor-dtor-privacy
            -Wdangling-else
            -Wdate-time
            -Wdelete-incomplete
            -Wdelete-non-virtual-dtor
            -Wdeprecated
            -Wdeprecated-copy
            -Wdeprecated-copy-dtor
            -Wdeprecated-declarations
            -Wdeprecated-enum-enum-conversion
            -Wdeprecated-enum-float-conversion
            -Wdisabled-optimization
            -Wdiv-by-zero
            -Wdouble-promotion
            -Wempty-body
            -Wendif-labels
            -Wenum-compare
            -Wenum-conversion
            -Wexceptions
            -Wexpansion-to-defined
            -Wextra
            -Wextra-semi
            -Wfloat-conversion
            -Wfloat-equal
            -Wformat
            -Wformat-extra-args
            -Wformat-nonliteral
            -Wformat-security
            -Wformat-y2k
            -Wformat-zero-length
            -Wframe-address
            -Wfree-nonheap-object
            -Wignored-attributes
            -Wignored-qualifiers
            -Winaccessible-base
            -Winit-self
            -Wint-in-bool-context
            -Wint-to-pointer-cast
            -Winvalid-offsetof
            -Winvalid-pch
            -Wlogical-not-parentheses
            -Wmain
            -Wmemset-transposed-args
            -Wmisleading-indentation
            -Wmismatched-new-delete
            -Wmismatched-tags
            -Wmissing-field-initializers
            -Wmissing-include-dirs
            -Wmultichar
            -Wnarrowing
            -Wnoexcept-type
            -Wnon-virtual-dtor
            -Wnonnull
            -Wnull-dereference
            -Wodr
            -Wold-style-cast
            -Woverflow
            -Woverlength-strings
            -Woverloaded-virtual
            -Wpacked
            -Wparentheses
            -Wpedantic
            -Wpessimizing-move
            -Wpointer-arith
            -Wpointer-compare
            -Wpragmas
            -Wpsabi
            -Wrange-loop-construct
            -Wredundant-decls
            -Wredundant-move
            -Wregister
            -Wreorder
            -Wreturn-local-addr
            -Wreturn-type
            -Wsequence-point
            -Wshadow
            -Wshift-count-negative
            -Wshift-count-overflow
            -Wshift-negative-value
            -Wsign-compare
            -Wsign-conversion
            -Wsign-promo
            -Wsizeof-array-argument
            -Wsizeof-array-div
            -Wsizeof-pointer-div
            -Wsizeof-pointer-memaccess
            -Wstack-protector
            -Wstring-compare
            -Wsuggest-override
            -Wswitch
            -Wswitch-bool
            -Wswitch-default
            -Wswitch-enum
            -Wtautological-compare
            -Wtrigraphs
            -Wtype-limits
            -Wundef
            -Wuninitialized
            -Wunknown-pragmas
            -Wunreachable-code
            -Wunused
            -Wunused-but-set-parameter
            -Wunused-but-set-variable
            -Wunused-function
            -Wunused-label
            -Wunused-local-typedefs
            -Wunused-macros
            -Wunused-result
            -Wunused-value
            -Wunused-variable
            -Wvarargs
            -Wvariadic-macros
            -Wvector-operation-performance
            -Wvla
            -Wvolatile-register-var
            -Wwrite-strings
            -Wzero-as-null-pointer-constant
        )
    else() # TODO: other compilers if required
        set(CMAKE_TESTBENCH_WARNINGS "")
    endif()
endmacro()


#------------------------------------------------------------------------------
# GCC / MinGW
# The warnings below are disabled.
#
#
# | Warning                         | Reason to discard it                                                                                                                          |
# |---------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------|
# | -Wabi                           | Not interested in this for now. Maybe later.                                                                                                  |
# | -Wabsolute-value                | C and Objective-C only                                                                                                                        |
# | -Waggregate-return              | Prevents from returning structs, classes or unions that are aggregates (https://en.cppreference.com/w/cpp/language/aggregate_initialization). |
# | -Wbad-function-cast             | C and Objective-C only                                                                                                                        |
# | -Wc++-compat                    | C and Objective-C only                                                                                                                        |
# | -Wc11-c2x-compat                | C and Objective-C only                                                                                                                        |
# | -Wc90-c99-compat                | C and Objective-C only                                                                                                                        |
# | -Wc99-c11-compat                | C and Objective-C only                                                                                                                        |
# | -Wdeclaration-after-statement   | C and Objective-C only                                                                                                                        |
# | -Wdesignated-init               | C++20 mandates to support this feature.                                                                                                       |
# | -Wdiscarded-array-qualifiers    | C and Objective-C only                                                                                                                        |
# | -Wdiscarded-qualifiers          | C and Objective-C only                                                                                                                        |
# | -Wduplicate-decl-specifier      | C and Objective-C only                                                                                                                        |
# | -Winline                        | It's the compiler that decides if something should be inlined. There is no way to force it.                                                   |
# | -Wimplicit                      | C and Objective-C only                                                                                                                        |
# | -Wimplicit-function-declaration | C and Objective-C only                                                                                                                        |
# | -Wimplicit-int                  | C and Objective-C only                                                                                                                        |
# | -Wincompatible-pointer-types    | C and Objective-C only                                                                                                                        |
# | -Wint-conversion                | C and Objective-C only                                                                                                                        |
# | -Wjump-misses-init              | C and Objective-C only                                                                                                                        |
# | -Wlong-long                     | This is for compatibility with C++98.                                                                                                         |
# | -Wmissing-braces                | Disables initalisations of arrays like std::array<int, 3> a = {1, 2, 3}; (requires additional inner braces)                                   |
# | -Wmissing-declarations          | Warns when a function is defined without a prototype (except templates). It's annoying.                                                       |
# | -Wmissing-parameter-type        | C and Objective-C only                                                                                                                        |
# | -Wmissing-prototypes            | C and Objective-C only                                                                                                                        |
# | -Wnested-externs                | C and Objective-C only                                                                                                                        |
# | -Wold-style-declaration         | C and Objective-C only                                                                                                                        |
# | -Wold-style-definition          | C and Objective-C only                                                                                                                        |
# | -Woverride-init                 | C and Objective-C only                                                                                                                        |
# | -Woverride-init-side-effects    | C and Objective-C only                                                                                                                        |
# | -Wpadded                        | Warns when structs are padded. Not relevant yet.                                                                                              |
# | -Wpointer-sign                  | C and Objective-C only                                                                                                                        |
# | -Wpointer-to-int-cast           | C and Objective-C only                                                                                                                        |
# | -Wstrict-prototypes             | C and Objective-C only                                                                                                                        |
# | -Wsystem-headers                | Well, we don't want std namespace warnings in.                                                                                                |
# | -Wtraditional                   | C and Objective-C only                                                                                                                        |
# | -Wunsuffixed-float-constants    | C and Objective-C only                                                                                                                        |
# | -Wtraditional-conversion        | C and Objective-C only                                                                                                                        |
#
# Warnings specific to C++:
#
# | Warning                   | Reason to discard it                                                          |
# |---------------------------|-------------------------------------------------------------------------------|
# | -Wabi-tag                 | We don't care about ABI tags yet.                                             |
# | -Wc++11-compat            | Correct is selected by -Wall.                                                 |
# | -Wc++14-compat            | Correct is selected by -Wall.                                                 |
# | -Wc++17-compat            | Correct is selected by -Wall.                                                 |
# | -Wc++20-compat            | Correct is selected by -Wall.                                                 |
# | -Wcatch-value=<0,3>       | All are enabled by -Wall.                                                     |
# | -Wconditionally-supported | Warn for conditionally-supported (C++11) constructs. We're far in the future. |
# | -Weffc++                  | It's a style guide. Not a real warning.                                       |
# | -Winvalid-imported-macros | Useful, but very heavy.                                                       |
# | -Wmultiple-inheritance    | There are places where multiple inheritance is okay.                          |
# | -Wnamespaces              | Why would we disable namespaces ?                                             |
# | -Wsynth                   | Warns when g++ synthesis does not match cfront's one. We don't care.          |
# | -Wtemplates               | Forbids templates. Seriously ?                                                |
# | -Wvirtual-inheritance     | There are places where virtual inheritance is okay... I guess.                |
#
#------------------------------------------------------------------------------
# Clang - GCC warnings
#
# The following warnings (enabled when compiling with GCC) are not supported by clang:
#
# | Warning                                        |
# |------------------------------------------------|
# | -Waggressive-loop-optimizations                |
# | -Waligned-new                                  |
# | -Walloc-zero                                   |
# | -Wanalyzer-double-fclose                       |
# | -Wanalyzer-double-free                         |
# | -Wanalyzer-exposure-through-output-file        |
# | -Wanalyzer-file-leak                           |
# | -Wanalyzer-free-of-non-heap                    |
# | -Wanalyzer-malloc-leak                         |
# | -Wanalyzer-mismatching-deallocation            |
# | -Wanalyzer-null-argument                       |
# | -Wanalyzer-null-dereference                    |
# | -Wanalyzer-possible-null-argument              |
# | -Wanalyzer-possible-null-dereference           |
# | -Wanalyzer-shift-count-negative                |
# | -Wanalyzer-shift-count-overflow                |
# | -Wanalyzer-stale-setjmp-buffer                 |
# | -Wanalyzer-tainted-array-index                 |
# | -Wanalyzer-too-complex                         |
# | -Wanalyzer-unsafe-call-within-signal-handler   |
# | -Wanalyzer-use-after-free                      |
# | -Wanalyzer-use-of-pointer-in-stale-stack-frame |
# | -Wanalyzer-write-to-const                      |
# | -Wanalyzer-write-to-string-literal             |
# | -Warith-conversion                             |
# | -Wbool-compare                                 |
# | -Wbuiltin-declaration-mismatch                 |
# | -Wcannot-profile                               |
# | -Wcast-align=strict                            |
# | -Wclass-memaccess                              |
# | -Wclobbered                                    |
# | -Wcomma-subscript                              |
# | -Wcoverage-mismatch                            |
# | -Wduplicated-branches                          |
# | -Wduplicated-cond                              |
# | -Wformat-contains-nul                          |
# | -Wformat-diag                                  |
# | -Wformat-signedness                            |
# | -Whsa                                          |
# | -Wif-not-aligned                               |
# | -Winherited-variadic-ctor                      |
# | -Winit-list-lifetime                           |
# | -Winvalid-memory-model                         |
# | -Wliteral-suffix                               |
# | -Wlogical-op                                   |
# | -Wlto-type-mismatch                            |
# | -Wmaybe-uninitialized                          |
# | -Wmemset-elt-size                              |
# | -Wmismatched-dealloc                           |
# | -Wmissing-attributes                           |
# | -Wmissing-profile                              |
# | -Wmultistatement-macros                        |
# | -Wnoexcept                                     |
# | -Wnon-template-friend                          |
# | -Wnonnull-compare                              |
# | -Wopenmp-simd                                  |
# | -Wpacked-bitfield-compat                       |
# | -Wpacked-not-aligned                           |
# | -Wplacement-new=1                              |
# | -Wpmf-conversions                              |
# | -Wprio-ctor-dtor                               |
# | -Wredundant-tags                               |
# | -Wrestrict                                     |
# | -Wscalar-storage-order                         |
# | -Wshadow=compatible-local                      |
# | -Wshadow=local                                 |
# | -Wsized-deallocation                           |
# | -Wstrict-null-sentinel                         |
# | -Wstringop-overread                            |
# | -Wstringop-truncation                          |
# | -Wsubobject-linkage                            |
# | -Wsuggest-attribute=cold                       |
# | -Wsuggest-attribute=const                      |
# | -Wsuggest-attribute=format                     |
# | -Wsuggest-attribute=malloc                     |
# | -Wsuggest-attribute=noreturn                   |
# | -Wsuggest-attribute=pure                       |
# | -Wsuggest-final-methods                        |
# | -Wsuggest-final-types                          |
# | -Wswitch-outside-range                         |
# | -Wswitch-unreachable                           |
# | -Wsync-nand                                    |
# | -Wterminate                                    |
# | -Wtrampolines                                  |
# | -Wtsan                                         |
# | -Wunsafe-loop-optimizations                    |
# | -Wuseless-cast                                 |
# | -Wvexing-parse                                 |
# | -Wvirtual-inheritance                          |
# | -Wvirtual-move-assign                          |
# | -Wvla-parameter                                |
# | -Wvolatile                                     |
# | -Wzero-length-bounds                           |
#
#------------------------------------------------------------------------------
# MSVC
#
# | Warning | Reason to discard it                                                                                                  |
# |---------|-----------------------------------------------------------------------------------------------------------------------|
# | /wd4514 | Informative warning about inline functions being removed in some translation units. We do not care about that.        |
# | /wd4710 | Same as Winline for GCC. This is purely informative, no way to fix it. Also gets trigger in Standard Library Headers. |
# | /wd4711 | Opposite of 4710, but still informative. And gets triggered in standard library headers.                              |
# | /wd4625 | Informative warning, this is OK for aggregates and similar constructs.                                                |
# | /wd4626 | Informative warning, this is OK for aggregates and similar constructs.                                                |
# | /wd4668 | Gets triggered in Standard Library headers. Warnings of this kind get caught when compiling with GCC any way.         |
# | /wd4820 | Padded struct are what all compilers do any way.                                                                      |
# | /wd5026 | Erronously triggered for aggregates.                                                                                  |
# | /wd5027 | Erronously triggered for aggregates.                                                                                  |
# | /wd5045 | We don't compile with QSpectre and there is no plan for it.                                                           |
# | /wd5246 | Equivalent of -Wmissing-braces which we disable in GCC/clang                                                          |
