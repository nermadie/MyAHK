pasteContent = 
(LTrim
	class A{
	        private:

	        public:

	};	
)

F1::
	Clipboard := pasteContent
	Send, ^V
	Clipboard :=
	Send, {UP}{UP}{UP}{UP}{UP}{end}{left}
return