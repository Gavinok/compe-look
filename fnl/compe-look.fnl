;; TODO add Source.documentation(self, context)
;;   and use a dictionary to find the definition of context.completed.word
(local compe (require :compe))
(local Job (require :plenary.job))

(local Source [])

(fn Source.new []
  (let [self (setmetatable {} {:__index Source})]
    self))

(fn Source.get_metadata [self]
  {:priority 100 :dup 0 :menu "[look]"})

(fn Source.determine [self context]
  (compe.helper.determine context))

(fn Source.complete [self context]
  (self:collect (context.context.line:match "%a+$") context.callback))

(fn Source.collect [self substring callback]
  "Returns the words in a dictionary matching the given SUBSTRING"
  (var results [])
  (let [job (Job:new {:command :look
                      :args [:-f
                             substring
                             ; dynamically define the dictionary
                             (or (. (vim.split vim.o.dictionary "," true) 1) "")]
                      :on_exit (fn [job return]
                                 (let [words (job:result)]
                                   (each [_ word (ipairs words)]
                                     (table.insert results {: word})
                                     (callback {:items results
                                                :incomplete true}))))})]
    (job:start))
  results)

(compe.register_source :look Source)
