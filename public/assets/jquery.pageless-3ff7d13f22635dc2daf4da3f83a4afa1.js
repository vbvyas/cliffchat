!function(e){var t,n,i=!1,r=!i,o=i,a={container:window,currentPage:1,distance:100,pagination:".pagination",params:{},url:location.href,loaderImage:"/images/load.gif"},s=a.container;e.pageless=function(t){e.isFunction(t)?a.call():u(t)};var l=function(){return a.loaderHtml||'<div id="pageless-loader" style="display:none;text-align:center;width:100%;">  <div class="msg" style="color:#e9e9e9;font-size:2em"></div>  <img src="'+a.loaderImage+'" alt="loading more results" style="margin:10px auto" /></div>'},u=function(t){a.inited||(a.inited=r,t&&e.extend(a,t),a.pagination&&e(a.pagination).remove(),f())};e.fn.pageless=function(i){var r=e(this),o=e(i.loader,r);u(i),t=r,i.loader&&o.length?n=o:(n=e(l()),r.append(n),i.loaderHtml||e("#pageless-loader .msg").html(i.loaderMsg))};var c=function(e){(o=e)?n&&n.fadeIn("normal"):n&&n.fadeOut("normal")},d=function(){return s===window?e(document).height()-e(s).scrollTop()-e(s).height():e(s)[0].scrollHeight-e(s).scrollTop()-e(s).height()},p=function(){e(s).unbind(".pageless")},f=function(){e(s).bind("scroll.pageless",h).trigger("scroll.pageless")},h=function(){return a.totalPages<=a.currentPage?(p(),a.end&&a.end.call(),void 0):(!o&&d()<a.distance&&(c(r),a.currentPage++,e.extend(a.params,{page:a.currentPage}),e.get(a.url,a.params,function(r){e.isFunction(a.scrape)?a.scrape(r):r,n?n.before(r):t.append(r),c(i),a.complete&&a.complete.call()})),void 0)}}(jQuery);