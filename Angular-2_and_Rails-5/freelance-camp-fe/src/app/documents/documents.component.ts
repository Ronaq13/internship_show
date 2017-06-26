import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs/Rx';
import { DocumentService } from './document.service'
import { Document } from './documents';

@Component({
  moduleId: module.id,
  selector: 'documents',
  templateUrl: './documents.component.html',
  styleUrls: ['./documents.component.css'],
  providers: [DocumentService]
})

export class DocumentsComponent implements OnInit {

  pageTitle:string = "Document Dashboard"
  // here Document is our custom datatype which we created in documents.ts
  documents: Document[];
  errorMessage:string;
  mode = "Observable";

  constructor(
    private documentService: DocumentService
  ){}

  ngOnInit(){
    let timer = Observable.timer(0,5000);
    timer.subscribe(()=>this.getDocuments());
  }

  getDocuments() {
    this.documentService.getDocuments()
        .subscribe(
          documents => this.documents = documents,
          error => this.errorMessage = <any>error
        )
  }
}
