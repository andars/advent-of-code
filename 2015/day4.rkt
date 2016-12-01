#lang racket/base

;takes forever, super inefficient

(provide is-solution)
(require file/md5)
(require racket/format)
(require racket/file)

(define input (car (file->lines "inputs/day04.txt")))
(displayln input)

(define (is-solution in n)
  (let ([hash (bytes->string/utf-8 (md5 (string-append input (~a in))))])
    (cond ((equal? (substring hash 0 n) (make-string n #\0))
            (displayln (string-append input (~a in)))
            (displayln hash)
            (displayln in)
           #t)
          (else #f))))

(for ([i (in-naturals)])
     #:break (is-solution i 6)
    (is-solution i 5))
