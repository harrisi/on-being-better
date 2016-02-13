#lang racket
(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))))

(define almost-factorial
  (λ (f)
    (λ (n)
      (if (= n 0)
          1
          (* n (f (- n 1)))))))

(define fibonacci
  (λ (n)
    (cond ((= n 0) 0)
          ((= n 1) 1)
          (else (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))))

(define almost-fibonacci
  (λ (f)
    (λ (n)
      (cond ((= n 0) 0)
            ((= n 1) 1)
            (else (+ (f (- n 1)) (f (- n 2))))))))

(define identity
  (λ (x) x))

(define factorial0 (almost-factorial identity))

(define factorial1 (almost-factorial factorial0))

;; lazy
;;(define Y
;;  (λ (f)
;;    (f (Y f))))

(define Y
  (λ (f)
    (f (λ (x) ((Y f) x)))))

;;(define factorialA (almost-factorial factorialA))

;;(define factorialB (almost-factorial factorialA))

;;(define factorialB
;;  ((λ (f)
;;     (λ (n)
;;       (if (= n 0)
;;           1
;;           (* n (f (- n 1))))))
;;   factorialA))