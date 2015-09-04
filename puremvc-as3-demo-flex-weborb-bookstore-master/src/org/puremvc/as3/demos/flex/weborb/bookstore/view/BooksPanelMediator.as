/* 
 PureMVC AS3 Demo - Flex/WebORB Bookstore
 By David Deraedt <david.deraedt@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.weborb.bookstore.view
{
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	import org.puremvc.as3.demos.flex.weborb.bookstore.*;
	import org.puremvc.as3.demos.flex.weborb.bookstore.model.*;
	import org.puremvc.as3.demos.flex.weborb.bookstore.model.vo.*;
	import org.puremvc.as3.demos.flex.weborb.bookstore.view.components.*;
	
	public class BooksPanelMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = 'BooksPanelMediator';
		
		public function BooksPanelMediator(viewComponent:Object)
		{
			super(NAME,viewComponent);
			
			booksPanel.addEventListener(BooksPanel.CREATE, onCreate);
			booksPanel.addEventListener(BooksPanel.REMOVE, onDelete);
			booksPanel.addEventListener(BooksPanel.SELECT, onSelect);
			
			bookProxy = facade.retrieveProxy(BookProxy.NAME) as BookProxy ;
			
			booksPanel.books = bookProxy.books;
		}
		
		private function onCreate(pEvt:Event):void
		{
			var newBook:Book = new Book();
			newBook.title="New";
			newBook.idauthor=1;
			newBook.date="2008-01-01";
			newBook.price=0;
			newBook.is_public=true;
			
			bookProxy.createBook(newBook);
			
		}
		
		private function onSelect(pEvt:Event):void
		{
			sendNotification(ApplicationFacade.BOOK_SELECTED, booksPanel.selectedBook);
		}
		
		private function onDelete(pEvt:Event):void
		{
			bookProxy.deleteBook(booksPanel.selectedBook);
		}
		
		override public function listNotificationInterests():Array
		{
			return [ ApplicationFacade.BOOK_SELECTED ];		
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch ( notification.getName() )
			{

				case ApplicationFacade.BOOK_SELECTED:
					booksPanel.selectedBook = notification.getBody() as Book;
					break;
			}
		}
		
		private function get booksPanel():BooksPanel
		{
			return viewComponent as BooksPanel;
		}
		
		private var bookProxy:BookProxy;
	}
	
}