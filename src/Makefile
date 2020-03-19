VERSION = 6.4.6
ACCOUNT = bwpger

# Strip any '.rcN' or '.tN' from VERSION.
FINAL_VERSION=$(shell echo $(VERSION) | sed -e 's/\.rc.*$$//' -e 's/\.t[0-9]$$//')

SERVICE = agraph
TAG = $(ACCOUNT)/$(SERVICE):v$(VERSION)
LATEST_TAG = $(ACCOUNT)/$(SERVICE):latest

TGZ = agraph-$(FINAL_VERSION)-linuxamd64.64.tar.gz

BWPGER_AGRAPH_APPDIR = \/opt\/agraph
BWPGER_AGRAPH_BINDIR = \/opt\/agraph\/bin
BWPGER_AGRAPH_DATADIR = \/var\/data\/db\/agraph\/data
BWPGER_AGRAPH_LOGDIR = \/var\/data\/db\/agraph\/log
BWPGER_AGRAPH_CONFIGFILE = \/etc\/agraph\/agraph.conf
BWPGER_AGRAPH_CONFIGDIR = \/etc\/agraph
BWPGER_AGRAPH_PIDFILE = \/var\/data\/db\/agraph\/log\/pid.log
BWPGER_AGRAPH_APPUSER = agraph
BWPGER_AGRAPH_APPUID = 42004
BWPGER_AGRAPH_APPGROUP = db
BWPGER_AGRAPH_APPGID = 20005
BWPGER_AGRAPH_SUPERUSER = dbadmin
BWPGER_AGRAPH_SUPERPASSWORD = Dt619pa7Ie4viydt
BWPGER_AGRAPH_CONTAINER_ID = ${CONTAINER_ID}

default: Dockerfile
	docker build -t $(TAG) .
	docker tag $(TAG) $(LATEST_TAG)

Dockerfile:
	@echo "Agraph Super User ...: \"$(BWPGER_AGRAPH_SUPERUSER)\"."
	@echo "Agraph Super Password: \"$(BWPGER_AGRAPH_SUPERPASSWORD)\"."
	sed -e 's/__TGZ__/$(TGZ)/g' \
	    -e 's/__VERSION__/$(VERSION)/g' \
	    -e 's/__FINAL_VERSION__/$(FINAL_VERSION)/g' \
	    -e 's/__BWPGER_AGRAPH_APPDIR__/$(BWPGER_AGRAPH_APPDIR)/g' \
	    -e 's/__BWPGER_AGRAPH_BINDIR__/$(BWPGER_AGRAPH_BINDIR)/g' \
	    -e 's/__BWPGER_AGRAPH_DATADIR__/$(BWPGER_AGRAPH_DATADIR)/g' \
	    -e 's/__BWPGER_AGRAPH_LOGDIR__/$(BWPGER_AGRAPH_LOGDIR)/g' \
	    -e 's/__BWPGER_AGRAPH_CONFIGFILE__/$(BWPGER_AGRAPH_CONFIGFILE)/g' \
	    -e 's/__BWPGER_AGRAPH_CONFIGDIR__/$(BWPGER_AGRAPH_CONFIGDIR)/g' \
	    -e 's/__BWPGER_AGRAPH_PIDFILE__/$(BWPGER_AGRAPH_PIDFILE)/g' \
	    -e 's/__BWPGER_AGRAPH_APPUSER__/$(BWPGER_AGRAPH_APPUSER)/g' \
	    -e 's/__BWPGER_AGRAPH_APPUID__/$(BWPGER_AGRAPH_APPUID)/g' \
	    -e 's/__BWPGER_AGRAPH_APPGROUP__/$(BWPGER_AGRAPH_APPGROUP)/g' \
	    -e 's/__BWPGER_AGRAPH_APPGID__/$(BWPGER_AGRAPH_APPGID)/g' \
	    -e 's/__BWPGER_AGRAPH_SUPERUSER__/$(BWPGER_AGRAPH_SUPERUSER)/g' \
	    -e 's/__BWPGER_AGRAPH_SUPERPASSWORD__/$(BWPGER_AGRAPH_SUPERPASSWORD)/g' \
	    dockerfile.in > Dockerfile

push:
	docker push $(TAG)
	docker push $(LATEST_TAG)

clean:
	rm -f Dockerfile
	# docker stop $(docker ps -aq) 2>/dev/null
	docker-compose rm -s -f -v $(SERVICE)
	docker image rm -f $(TAG)
	docker image rm -f $(LATEST_TAG)
	docker container prune -f

run:
	docker-compose up

run-detached:
	docker-compose up -d

shell:
	docker exec -it $(BWPGER_AGRAPH_CONTAINER_ID)  bash
