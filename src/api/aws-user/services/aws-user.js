'use strict';

/**
 * aws-user service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::aws-user.aws-user');
