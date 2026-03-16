#import "src/dissertation.typ": dissertation
#import "src/thesis.typ": thesis
#import "src/content-page.typ": flex-caption
// Re-export glossarium helpers so users only need to import from lib.typ
#import "@preview/glossarium:0.5.10": gls, glspl
// Re-export alexandria helpers for multi-bibliography support
// (own-publications, supervised-theses, own-patents alongside main bibliography)
#import "@preview/alexandria:0.2.2": alexandria, bibliographyx
