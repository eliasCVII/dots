;; This script prints the currently clocked-in org headline (if any)
(require 'org)
(require 'org-clock)
(when (org-clocking-p)
  (princ org-clock-heading))
