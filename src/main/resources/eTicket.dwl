%dw 2.0
output application/java
ns soap http://schemas.xmlsoap.org/soap/envelope
ns ns1 http://bookmyshow.booking.com/
var totalTicketPrice = payload.bookingPrice as Number * payload.numberOfTickets as Number
---
{	
    body: {
    	ns1#InsertBookingResponse: {
    		return:{
    			NumberOfTickets: payload.numberOfTickets,
    			TotalPrice: totalTicketPrice - (((payload.discountOffered as Number)/100) * totalTicketPrice),
    			BookingTiming: now() as String {format: p('bookings.responseDateFormat')},
    			ShowTiming: payload.showTiming,
    			CustomerName: payload.customerName,
    			TheaterName: vars.theaterName[0].theaterName,
    			BookingID: vars.bookingID
    		}
        }
    }  write "application/xml"
}