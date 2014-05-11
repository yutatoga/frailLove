#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){	
		//		player.loadSound("pinkNoise.wav");
		//		player.setLoop(true);
		font.loadFont("MyriadPro-Bold.otf", 270);
		ofSetOrientation(ofxiOS_ORIENTATION_LANDSCAPE_RIGHT);
		ofEnableAlphaBlending();
		ofEnableSmoothing();
		ofSetCircleResolution(64);
		getImage = false;
		lastEventTime = 0;
		lifeTime = 30;
}

//--------------------------------------------------------------
void ofApp::update(){
		if(ofGetElapsedTimef() - lastEventTime > lifeTime){
				drawPointVector.clear();
		}
}

//--------------------------------------------------------------
void ofApp::draw(){
		ofLog(OF_LOG_NOTICE, ofToString(drawPointVector.size()));
		if (!getImage) {
				font.drawString("LOVE", 80, ofGetHeight()/3.*2);
				screenImage.grabScreen(0, 0, ofGetWidth(), ofGetHeight());
				getImage = true;
		}
		ofPushStyle();
		ofSetColor(ofColor::white);
		ofRect(0, 0, ofGetWidth(), ofGetHeight());
		ofPopStyle();
		
		ofPushStyle();
		for (int i=0; i<drawPointVector.size(); i++) {
				float elapsedTimeAfterDrawn = ofGetElapsedTimef()-drawPointVector[i].w;
				// dissapear in "lifeTime" seconds;
//				float colorAlpha = 1-sin(elapsedTimeAfterDrawn/lifeTime*PI/2);
				float colorAlpha = (elapsedTimeAfterDrawn*elapsedTimeAfterDrawn-2*elapsedTimeAfterDrawn*lifeTime+lifeTime*lifeTime)/(lifeTime*lifeTime);
				if (elapsedTimeAfterDrawn > lifeTime) {
						ofColor circleColor(255, 0, 64, 0);
						ofSetColor(circleColor);
				}else{
						ofColor circleColor(255, 0, 64, 30*colorAlpha);
						circleColor.setSaturation(circleColor.getSaturation()*colorAlpha);
						ofSetColor(circleColor);
//						ofLog(OF_LOG_NOTICE, ofToString(circleColor));
				}
				ofCircle(drawPointVector[i].x, drawPointVector[i].y, drawPointVector[i].z);
		}
		ofPopStyle();
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
		if(screenImage.getColor(touch.x, touch.y).r == 255){
				drawPointVector.push_back(ofVec4f(touch.x, touch.y, ofRandom(10, 40), ofGetElapsedTimef()));
				//				player.play();
		}
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
		if(screenImage.getColor(touch.x, touch.y).r == 255){
				drawPointVector.push_back(ofVec4f(touch.x, touch.y, ofRandom(10, 40), ofGetElapsedTimef()));
				//				if (!player.getIsPlaying()) {
				//						player.play();
				//				}
		}
		//		else{
		//				player.stop();
		//		}
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
//		player.stop();
		lastEventTime = ofGetElapsedTimef();
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}
