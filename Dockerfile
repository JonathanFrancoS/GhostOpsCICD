FROM ghost:6.0.0-alpine

WORKDIR /var/lib/ghost

EXPOSE 2368

CMD ["node", "current/index.js"]
