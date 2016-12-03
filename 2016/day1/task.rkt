#lang racket


(define in (open-input-file "input.txt"))

(define directions
  (map string-trim (string-split (port->string in) ",")))

(define (new-orientation old change)
  (let ([a (car old)]
        [b (cdr old)])
    (cond
        ((eq? change #\L)
         (cons (- b) a))
        ((eq? change #\R)
         (cons b (- a)))
        (else (writeln change)))))

(define positions (mutable-set))
(define part2 #f)

(define (new-position pos orientation dist)
  (let loop ([curr pos]
             [d (- dist 1)])
    (let ([curr (cons (+ (car curr) (car orientation))
                      (+ (cdr curr) (cdr orientation)))])
      (when (and (set-member? positions curr) (not part2))
        (set! part2 curr))
      (set-add! positions curr)
      (cond
        [(= d 0) curr]
        [else (loop curr (- d 1))]))))


(define part1
  (let follow ([position (cons 0 0)]
               [orientation (cons 0 1)]
               [ds directions])
    (cond
      ((null? ds) position)
      ((char-alphabetic? (string-ref (car ds) 0))
       (follow position (new-orientation orientation (string-ref (car ds) 0))
               (cons (substring (car ds) 1) (cdr ds))))
      (else (follow (new-position position orientation
                                  (string->number (car ds)))
                    orientation
                    (cdr ds))))))

(define (dist pos)
  (+ (abs (car pos)) (abs (cdr pos))))

(writeln "Part 1 Solution:")
(writeln (dist part1))
(writeln "Part 2 Solution:")
(writeln (dist part2))