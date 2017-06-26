// These go in 'imports' section of meta data
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms'; // For Forms we need to include it
import { HttpModule } from '@angular/http';
import { NgModule } from '@angular/core';
import {NgbModule} from '@ng-bootstrap/ng-bootstrap';

//service
import { DocumentService } from './documents/document.service';
import { ProposalService } from './proposal/proposal.service';

// These are our custom components, and go under declarations
import { AppComponent } from './app.component';
import { HomepageComponent } from './homepage/homepage.component';
import { DocumentsComponent } from './documents/documents.component';
import { ProposalListComponent } from './proposal/proposal-list.component';
import { ProposalNewComponent } from './proposal/proposal-new.component';
import { ProposalShowComponent } from './proposal/proposal-show.component';

import { AppRoutingModule } from './app.routing.module';

@NgModule({
  declarations: [
    AppComponent,
    HomepageComponent,
    DocumentsComponent,
    ProposalListComponent,
    ProposalNewComponent,
    ProposalShowComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    NgbModule.forRoot(),
    HttpModule
  ],
  providers: [
    DocumentService,
    ProposalService
  ],
  bootstrap: [AppComponent] // Ther starting (root) component
})
export class AppModule { }
