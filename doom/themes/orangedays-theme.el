(require 'autothemer)
(autothemer-deftheme orangedays "Autothemer example..."

                     ;; Specify the color classes used by the theme
                     ((((class color) (min-colors #xFFFFFF))
                       ((class color) (min-colors #xFF)))

                      ;; Specify the color palette, color columns correspond to each of the classes above.
                      (orangedays-orange          "")
                      )

                     ((default             (:foreground )))

                     (provide-theme 'orangedays)
