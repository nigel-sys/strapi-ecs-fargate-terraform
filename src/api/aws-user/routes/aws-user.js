'use strict';

/**
 * aws-user router
 */

const { createCoreRouter } = require('@strapi/strapi').factories;

module.exports = createCoreRouter('api::aws-user.aws-user');
