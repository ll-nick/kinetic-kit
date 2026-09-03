// Compile-only: dissertation() with all defaults — every optional section absent.
// Verifies the template doesn't crash when no optional content is provided.
#import "/lib.typ": dissertation

#show: dissertation

= Chapter One

Simple content to satisfy the doc argument.
