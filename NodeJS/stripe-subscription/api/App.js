const Utilities = require('./Utilities')
const express = require('express');
const Route = express.Router();
const bodyParser 	= require('body-parser')

const AuthController = require('./controllers/AuthController')
const CrudController = require('./controllers/CrudController')
const SubscriptionController = require('./controllers/SubscriptionController')

/**
 * APIs V1 Routes
 */
Route.route('/api')
	.get((req, res) => Utilities.apiResponse(res, 200, 'Welcome API'))
	.all(Utilities.send405);

Route.route('/api/v1')
	.get((req, res) => Utilities.apiResponse(res, 200, 'APIs V1'))
	.all(Utilities.send405);

Route.route('/api/v1/auth/login')
	.post(AuthController.login)
	.all(Utilities.send405);

Route.route('/api/v1/auth/signup')
	.post(AuthController.signup)
	.all(Utilities.send405);

Route.route('/api/v1/auth/user')
	.get(Utilities.verifyAccessToken, AuthController.getUserDetails)
	.all(Utilities.send405);

Route.route('/api/v1/crud/users')
	.get(CrudController.getAllUsers)
	.all(Utilities.send405);

Route.route('/api/v1/crud/user/:user_id?')
	.post(CrudController.create)
	.get(CrudController.read)
	.put(CrudController.update)
	.delete(CrudController.delete)
	.all(Utilities.send405);

Route.route('/api/v1/subscription/create-plan')
	.post(SubscriptionController.createPlan)
	.all(Utilities.send405);

Route.route('/api/v1/subscription/get-all-plans')
	.post(SubscriptionController.getAllPlans)
	.all(Utilities.send405);

Route.route('/api/v1/subscription/delete-plan')
	.post(SubscriptionController.deletePlan)
	.all(Utilities.send405);

Route.route('/api/v1/subscription/create-coupon')
	.post(SubscriptionController.createCoupon)
	.all(Utilities.send405);

Route.route('/api/v1/subscription/get-all-coupons')
	.post(SubscriptionController.getAllCoupons)
	.all(Utilities.send405);

Route.route('/api/v1/subscription/delete-coupon')
	.post(SubscriptionController.deleteCoupon)
	.all(Utilities.send405);

Route.route('/api/v1/subscription/create-customer')
	.post(SubscriptionController.createCustomer)
	.all(Utilities.send405);

Route.route('/api/v1/subscription/get-all-customers')
	.post(SubscriptionController.getAllCustomers)
	.all(Utilities.send405);

Route.route('/api/v1/subscription/delete-customer')
	.post(SubscriptionController.deleteCustomer)
	.all(Utilities.send405);

Route.route('/api/v1/subscription/create-payment-method')
	.post(SubscriptionController.createPaymentMethod)
	.all(Utilities.send405);

Route.route('/api/v1/subscription/get-all-payment-methods')
	.post(SubscriptionController.getAllPaymentMethods)
	.all(Utilities.send405);

Route.route('/api/v1/subscription/delete-payment-method')
	.post(SubscriptionController.deletePaymentMethod)
	.all(Utilities.send405);

Route.route('/api/v1/subscription/create-subscription')
	.post(SubscriptionController.createSubscription)
	.all(Utilities.send405);

Route.route('/api/v1/subscription/get-all-subscriptions')
	.post(SubscriptionController.getAllSubscriptions)
	.all(Utilities.send405);

Route.route('/api/v1/subscription/delete-subscription')
	.post(SubscriptionController.deleteSubscription)
	.all(Utilities.send405);

Route.route('/api/v1/subscription/confirm-payment-intent')
	.post(SubscriptionController.confirmPaymentIntent)
	.all(Utilities.send405);

Route.route('/api/v1/subscription/create-token')
	.post(SubscriptionController.createToken)
	.all(Utilities.send405);

Route.route('/api/v1/subscription/webhook')
	.post(SubscriptionController.webhook)
	.all(Utilities.send405);

module.exports = Route