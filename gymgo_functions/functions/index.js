const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();
// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions

exports.notifyNewCheckIn = functions.firestore
    .document('CheckIn/{checkInId}')
    .onCreate(async (docSnapshot, context) => {
        const data = docSnapshot.data();
        const respGym = await admin.firestore().doc(`Gym/${data.gymId}`).get();
        const gym = respGym.data();
        const respOwner = await admin.firestore().doc(`user/${gym.userId}`).get();
        const owner = respOwner.data();
        console.log(owner);
        const tokenUser = owner.token;
        console.log(tokenUser)
        const payload = {
            notification: {
                title: 'Check In',
                body: `${data.nameUser} quiere ingresar a tu Gym.`,

            },
            data: {
                type: 'checkIn',
                id: docSnapshot.id,
                click_action: 'FLUTTER_NOTIFICATION_CLICK'
            }
        }

        return admin.messaging().sendToDevice(tokenUser, payload);
    })
    ;

exports.notifySuccesRegistrationGym = functions.firestore
    .document('Gym/{gymId}')
    .onUpdate(async (docSnapshot, context) => {
        const data = docSnapshot.before.data();
        if (!data.stateVerify) {
            const payload = {
                notification: {
                    title: 'Registro Completo',
                    body: `Su Gimnasio ${data.name} fue aceptado, ahora es parte de Gym Go.`,

                },
                data: {
                    type: 'gymsucces',
                    click_action: 'FLUTTER_NOTIFICATION_CLICK'
                }
            }
            const respOwner = await admin.firestore().doc(`user/${data.userId}`).get();
            const owner = respOwner.data();
            return admin.messaging().sendToDevice(owner.token, payload);

        }
        return;
    });

exports.notifyNewSubscription = functions.firestore
    .document('Subscription/{subscriptionId}')
    .onCreate(async (docSnapshot, context) => {
        const data = docSnapshot.data();
        if (data.gymId !== null) {

            const gymRes = await admin.firestore().doc(`Gym/${data.gymId}`).get();
            const gym = gymRes.data();
            const respOwner = await admin.firestore().doc(`user/${gym.userId}`).get();
            const owner = respOwner.data();
            console.log(owner);
            const tokenUser = owner.token;
            console.log(tokenUser)
            const payload = {
                notification: {
                    title: 'Nueva Suscripción',
                    body: `Tiene una nueva suscripción de ${data.nameUser}`,

                },
                data: {
                    type: 'subscription',
                    id: docSnapshot.id,
                    click_action: 'FLUTTER_NOTIFICATION_CLICK'
                }
            }

            return admin.messaging().sendToDevice(tokenUser, payload);
        }
        return ;
    })
    ;

