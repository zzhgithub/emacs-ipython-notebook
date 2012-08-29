(require 'ert)

(require 'ein-worksheet)
(require 'ein-testing-cell)

(defvar ein:testing-worksheet-example-data
  (list (ein:testing-codecell-data "code example input")
        (ein:testing-markdowncell-data "markdown example input")
        (ein:testing-rawcell-data "raw example input")
        (ein:testing-htmlcell-data "html example input")
        (ein:testing-headingcell-data "heading example input")))

(defun ein:testing-worksheet-new ()
  (make-instance 'ein:worksheet
                 :discard-output-p (cons #'ignore nil)))

(defun ein:testing-worksheet-to-json (data)
  (let* ((ws-0 (ein:testing-worksheet-new))
         (ws-1 (ein:testing-worksheet-new))
         (json-0 (ein:worksheet-to-json ws-0))
         (json-1 (ein:worksheet-to-json
                  (ein:worksheet-from-json ws-1
                                           (ein:json-read-from-string
                                            (json-encode json-0))))))
    (should (equal json-0 json-1))))

(ert-deftest ein:worksheet-to-json/empty ()
  (ein:testing-worksheet-to-json nil))

(ert-deftest ein:worksheet-to-json/example-data ()
  (ein:testing-worksheet-to-json ein:testing-worksheet-example-data))