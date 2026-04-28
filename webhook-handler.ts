import express from 'express';

const router = express.Router();

router.post('/webhook/ghl', express.json(), (req, res) => {
  const event = req.body;
  const type: string = event.type;

  console.log('GHL webhook received:', type);

  switch (type) {
    case 'ContactCreate':
    case 'ContactUpdate':
      handleContact(event);
      break;
    case 'OpportunityCreate':
    case 'OpportunityUpdate':
      handleOpportunity(event);
      break;
    case 'AppointmentCreate':
    case 'AppointmentUpdate':
      handleAppointment(event);
      break;
    case 'InboundMessage':
    case 'OutboundMessage':
      handleMessage(event);
      break;
    default:
      console.log('Unhandled event type:', type);
  }

  res.json({ received: true });
});

function handleContact(event: any) {
  // TODO: add contact handling logic
  console.log('Contact event:', event);
}

function handleOpportunity(event: any) {
  // TODO: add opportunity handling logic
  console.log('Opportunity event:', event);
}

function handleAppointment(event: any) {
  // TODO: add appointment handling logic
  console.log('Appointment event:', event);
}

function handleMessage(event: any) {
  // TODO: add message handling logic
  console.log('Message event:', event);
}

export default router;
