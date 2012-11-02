// Script by Drew Noakes
// http://drewnoakes.com
// 14 Dec 2006 - Initial release
// 08 Jun 2010 - Added support for password textboxes
function initHintTextboxes(){var a=document.getElementsByTagName("input");for(i=0;i<a.length;i++){var b=a[i];if(b.type!="text"&&b.type!="password")continue;b.className.indexOf(HintClass)!=-1&&(b.hintText=b.value,b.className=HintClass,b.onfocus=onHintTextboxFocus,b.onblur=onHintTextboxBlur)}}function onHintTextboxFocus(){var a=this;a.value.trim()==a.hintText&&(a.value="",a.className=HintActiveClass)}function onHintTextboxBlur(){var a=this;a.value.trim().length==0&&(a.value=a.hintText,a.className=HintClass)}var HintClass="hintTextbox",HintActiveClass="hintTextboxActive";String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g,"")},window.onload=initHintTextboxes