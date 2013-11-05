#lang racket

(require racket/draw)

(define k 960939379918958884971672962127852754715004339660129306651505519271702802395266424689642842174350718121267153782770623355993237280874144307891325963941337723487857735749823926629715517173716995165232890538221612403238855866184013235585136048828693337902491454229288667081096184496091705183454067827731551705405381627380967602565625016981482083418783163849115590225610003652351370343874461848378737238198224849863465033159410054974700593138339226497249461751545728366702369745461014655997933798537483143786841806593422227898388722980000748404719)

(define (formula x y)
  (< 1/2 
     (floor (remainder (floor (* (floor (/ y 17))
                                 (expt 2 (- 0
                                            (* 17 (floor x))
                                            (remainder (floor y) 17)))))
                       2))))

(define width 1060)
(define height 170)
(define target (make-bitmap width height))
(define dc (new bitmap-dc% [bitmap target]))
(send dc set-brush "black" 'solid)
(define px-size 10)

(define (tupper)
  (letrec ([f (lambda (n) 
                (let ([x (quotient n 17)]
                      [y (remainder n 17)])
                  (if (= x 106)
                      target
                      (begin (if (formula x (+ k y))
                                 (send dc draw-rectangle (- width (* px-size x) px-size) (* px-size y) px-size px-size)
                                 #f)
                             (f (+ n 1))))))])
    (f 0)))


(send (tupper) save-file "tupper.png" 'png)