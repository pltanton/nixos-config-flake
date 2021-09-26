colors:
''
(require 'base16-theme)

(defvar base16-nix-colors
  '(:base00 "${colors.base0}"
    :base01 "${colors.base1}"
    :base02 "${colors.base2}"
    :base03 "${colors.base3}"
    :base04 "${colors.base4}"
    :base05 "${colors.base5}"
    :base06 "${colors.base6}"
    :base07 "${colors.base7}"
    :base08 "${colors.base8}"
    :base09 "${colors.base9}"
    :base0A "${colors.base10}"
    :base0B "${colors.base11}"
    :base0C "${colors.base12}"
    :base0D "${colors.base13}"
    :base0E "${colors.base14}"
    :base0F "${colors.base15}")
  "All colors for Base16 Nix are defined here.")

;; Define the theme
(deftheme base16-nix)

;; Add all the faces to the theme
(base16-theme-define 'base16-nix base16-nix-colors)

;; Mark the theme as provided
(provide-theme 'base16-nix)

(provide 'base16-nix-theme)
''
