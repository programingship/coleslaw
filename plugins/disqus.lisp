(defpackage :coleslaw-disqus
  (:use :cl)
  (:export #:enable)
  (:import-from :coleslaw #:add-injection
                          #:post))

(in-package :coleslaw-disqus)

(defvar *disqus-header*
  "<script type=\"text/javascript\">
   var disqus = {
   load : function disqus(){
       var disqus_shortname = '~a';
       if(typeof DISQUS !== 'object') {
         (function () {
         var s = document.createElement('script'); s.async = true;
         s.type = 'text/javascript';
         s.src = '//' + disqus_shortname + '.disqus.com/embed.js';
         (document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0]).appendChild(s);
         }());
	 document.getElementById('load-disqus').remove();
       }
       return true;
   }
   }
</script>
<a href=\"#disqus_thread\" onclick=\"return disqus.load();\" id=\"load-disqus\">
Load Disqus
</a>
<div id=\"disqus_thread\"></div>")

(defun enable (&key shortname)
  (flet ((inject-p (x)
           (when (typep x 'post)
             (format nil *disqus-header* shortname))))
    (add-injection #'inject-p :body)))
