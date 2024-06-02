const Utilities = require('../Utilities')
const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);

class SubscriptionController {

    async createPlan(req, res) {
        try {
            const { product_name, product_description, product_type, price_amount, currency, interval, nickname } = req.body
            const product = await stripe.products.create({
                name: product_name,
                description: product_description,
                type: product_type || 'service',
            });

            const price = await stripe.prices.create({
                product: product.id,
                unit_amount: price_amount,
                currency: currency || 'usd',
                recurring: { interval: interval || 'month' },
                nickname: nickname || '',
            });
            Utilities.apiResponse(res, 200, 'Plan Has Been Created Successfully!', {product, price})
        } catch (error) {
            Utilities.apiResponse(res, 500, error)
        }
    }

    async getAllPlans(req, res) {
        try {
            const products = await stripe.products.list();
            const prices = await stripe.prices.list();

            const subscriptionPlans = products.data.map(product => {
                const productPrices = prices.data.filter(price => price.product === product.id);
                return {
                    product,
                    prices: productPrices,
                }
            })

            Utilities.apiResponse(res, 200, 'Get All Subscription Plan Successfully!', subscriptionPlans)
        } catch (error) {
            Utilities.apiResponse(res, 500, error)
        }
    }

    async deletePlan(req, res) {
        try {
            const { product_id } = req.body
            const deletedProduct = await stripe.products.del(product_id);
            Utilities.apiResponse(res, 200, 'Subscription Plan Has Been Deleted Successfully!', deletedProduct)
        } catch (error) {
            Utilities.apiResponse(res, 500, error)
        }
    }

    async createCoupon(req, res) {
        try {
            const coupon = await stripe.coupons.create({
                name: '10OFF',
                percent_off: 10, 
                duration: 'once',
                // duration_in_months: 3,
              });
            Utilities.apiResponse(res, 200, 'Coupon Has Been Created Successfully!', coupon)
        } catch (error) {
            Utilities.apiResponse(res, 500, error.message)
        }
    }

    async getAllCoupons(req, res) {
        try {
            const coupons = await stripe.coupons.list();
            Utilities.apiResponse(res, 200, 'Get All Coupons Successfully!', coupons)
        } catch (error) {
            Utilities.apiResponse(res, 500, error.message)
        }
    }

    async deleteCoupon(req, res) {
        try {
            const { coupon_id } = req.body
            const deletedCoupon = await stripe.coupons.del(coupon_id);
            Utilities.apiResponse(res, 200, 'Coupon Has Been Deleted Successfully!', deletedCoupon)
        } catch (error) {
            Utilities.apiResponse(res, 500, error.message)
        }
    }

    async createCustomer(req, res) {
        try {
            let { email, name, source } = req.body
            const stripeCustomer = await stripe.customers.create({ email, name, source })
            Utilities.apiResponse(res, 200, 'Customer Has Been Create Successfully!', stripeCustomer)
        } catch (error) {
            Utilities.apiResponse(res, 500, error)
        }
    }

    async getAllCustomers(req, res) {
        try {
            const customers = await stripe.customers.list();
            Utilities.apiResponse(res, 200, 'Customer Has Been Create Successfully!', customers)
        } catch (error) {
            Utilities.apiResponse(res, 500, error)
        }
    }

    async deleteCustomer(req, res) {
        try {
            const { customer_id } = req.body
            const deletedCustomer = await stripe.customers.del(customer_id)
            Utilities.apiResponse(res, 200, 'Customer Has Been Create Successfully!', deletedCustomer)
        } catch (error) {
            Utilities.apiResponse(res, 500, error)
        }
    }

    async createPaymentMethod(req, res) {
        try {
            let { card_number, exp_month, exp_year, cvc } = req.body
            const card = {
                number: card_number,
                exp_month: exp_month,
                exp_year: exp_year,
                cvc: cvc,
            }
            const paymentMethod = await stripe.paymentMethods.create({ type: 'card', card });
            Utilities.apiResponse(res, 200, 'Payment Method Has Been Create Successfully!', paymentMethod)
        } catch (error) {
            Utilities.apiResponse(res, 500, error)
        }
    }

    async getAllPaymentMethods(req, res) {
        try {
            const { customer_id } = req.body
            const paymentMethods = await stripe.paymentMethods.list({customer: customer_id, type: 'card'});
            Utilities.apiResponse(res, 200, 'Get All Payment Method Successfully!', paymentMethods)
        } catch (error) {
            Utilities.apiResponse(res, 500, error)
        }
    }
    
    async deletePaymentMethod(req, res) {
        try {
            const { payment_method_id } = req.body
            const deletedPaymentMethod = await stripe.paymentMethods.detach(payment_method_id);
            Utilities.apiResponse(res, 200, 'Payment Method Has Been Deleted Successfully!', deletedPaymentMethod)
        } catch (error) {
            Utilities.apiResponse(res, 500, error)
        }
    }

    async createSubscription(req, res) {
        try {
            const { customer_id, coupon_code, price_id } = req.body
            const currentUnixTime = Math.floor(Date.now() / 1000);
            const cancelAt = currentUnixTime + (14 * 24 * 60 * 60);
            
            const subscription = await stripe.subscriptions.create({
                customer: customer_id,
                description: subscription_description,
                items: [{ price: price_id }],
                cancel_at: cancelAt,
                coupon: coupon_code,
                payment_behavior: 'default_incomplete',
                expand: ['latest_invoice.payment_intent'],
            })

            Utilities.apiResponse(res, 200, 'Subscription Has Been Created Successfully!', subscription)
        } catch (error) {
            Utilities.apiResponse(res, 500, error)
        }
    }

    async getAllSubscriptions(req, res) {
        try {
            const subscriptions = await stripe.subscriptions.list();
            Utilities.apiResponse(res, 200, 'Subscription Has Been Created Successfully!', subscriptions)
        } catch (error) {
            Utilities.apiResponse(res, 500, error.message)
        }
    }

    async deleteSubscription(req, res) {
        try {
            let { subscription_id } = req.body
            const subscription = await stripe.subscriptions.cancel(subscription_id);
            Utilities.apiResponse(res, 200, 'Subscription Has Been Canceled Successfully', subscription)
        } catch (error) {
            Utilities.apiResponse(res, 500, error)
        }
    }

    async confirmPaymentIntent(req, res) {
        try {
            let { payment_intent_id } = req.body
            const paymentIntent = await stripe.paymentIntents.confirm(payment_intent_id)
            Utilities.apiResponse(res, 200, 'Subscription Has Been Created Successfully!', paymentIntent)
        } catch (error) {
            Utilities.apiResponse(res, 500, error.message)
        }
    }

    async createToken(req, res) {
        try {
            let { card_number, exp_month, exp_year, cvc } = req.body
            const card = {
                number: card_number,
                exp_month: exp_month,
                exp_year: exp_year,
                cvc: cvc,
            }
            const token = await stripe.tokens.create({ card })
            Utilities.apiResponse(res, 200, 'Token Has Been Create Successfully!', token)
        } catch (error) {
            Utilities.apiResponse(res, 500, error)
        }
    }

    async webhook(req, res) {
        try {
            const { type, data: { object } } = req.body
            console.log('event.event ====>>>>>', object)
            switch (type) {
                case 'payment_intent.canceled':
                    console.log('payment_intent.canceled ====>>>>>')
                    break;
                case 'payment_intent.created':
                    console.log('payment_intent.created ====>>>>>')
                    break;
                case 'payment_intent.succeeded':
                    console.log('payment_intent.succeeded ====>>>>>')
                    break;
                case 'customer.subscription.deleted':
                    const priceIddel = 'price_1Nrc70AQhmiZrVesgK0Ha8Hk'
                    await stripe.subscriptions.create({
                        customer: "cus_Of2Md4EJuqkP9L",
                        description: "Subscription Purchase",
                        items: [{ price: priceIddel }],
                    })
                    console.log('customer.subscription.deleted ====>>>>>')
                    break;
                case 'customer.subscription.updated':
                    const priceId = 'price_1Nrc70AQhmiZrVesgK0Ha8Hk'
                    await stripe.subscriptions.create({
                        customer: "cus_Of1o2fVjuqIKCU",
                        description: "Subscription Purchase",
                        items: [{ price: priceId }],
                    })
                    console.log('customer.subscription.updated ====>>>>>')
                    break;
                default:
                    console.log(`Unhandled event type ====>>>>> ${type}`);
            }
            Utilities.apiResponse(res, 200, 'Get User Details Successfully', { type: type })
        } catch (error) {
            Utilities.apiResponse(res, 500, error)
        }
    }

}

module.exports = new SubscriptionController();