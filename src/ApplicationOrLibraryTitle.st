Smalltalk createPackage: 'ApplicationOrLibraryTitle'!
(Smalltalk packageAt: 'ApplicationOrLibraryTitle' ifAbsent: [ self error: 'Package not created: ApplicationOrLibraryTitle' ]) imports: {'amber/web/Web'. 'amber/web/Web-JQuery'. 'silk/Silk'}!
Object subclass: #ApplicationOrLibraryTitle
	slots: {}
	package: 'ApplicationOrLibraryTitle'!

!ApplicationOrLibraryTitle methodsFor: 'action'!

alert: aString after: aNumberOfMilliseconds
	[ Terminal alert: aString ] valueWithTimeout: aNumberOfMilliseconds
!

doAmberWith
	'#output-list' asBrush with: [ :html | html li: 'Amber Web #with: added me!!' ]
!

doConsoleLog
	| greeting target |
	greeting := 'Hello'.
	target := 'world'.
	console log: #{ #greeting -> greeting. #target -> target. #callback -> [ console log: greeting, ', ', target, '!!' ] }
!

doInspectStatus
	(self getApi: '/status')
		then: {#json. #inspect}
		catch: [ :err | Terminal alert: err ]
!

doJQueryAppend
	'#output-list' asJQuery append: '<li>jQuery append added me!!</li>'
!

doSilkTAG
	'#output-list' asSilk LI: 'Silk TAG: added me!!'
! !

!ApplicationOrLibraryTitle methodsFor: 'backend'!

endpoint
	"Return something like 'https://<char mess>.execute-api.eu-central-1.amazonaws.com/default'"
	^ self error: 'Not yet implemented'
!

getApi: path
	^ Platform fetch: self endpoint, path
! !

!ApplicationOrLibraryTitle methodsFor: 'starting'!

augmentPage
    '#lambda-status' asSilk on: #click bind: [ self doInspectStatus ].
	'#console-log' asSilk on: #click bind: [ self doConsoleLog ].
	'#timeout-alert' asSilk on: #click bind: [ self alert: 'REMINDER!!' after: 5000 ].
	'#amber-with' asBrush onClick: [ self doAmberWith ].
	'#silk-tag' asSilk on: #click bind: [ self doSilkTAG ].
	'#jquery-append' asJQuery click: [ self doJQueryAppend ]
! !

!ApplicationOrLibraryTitle class methodsFor: 'starting'!

start
	self new augmentPage
! !
