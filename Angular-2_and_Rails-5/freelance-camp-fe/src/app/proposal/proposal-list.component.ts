import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Observable } from 'rxjs/Rx';
import { ProposalService } from './proposal.service'
import { Proposal } from './proposal';

@Component({
  moduleId: module.id,
  selector: 'proposal',
  templateUrl: './proposal-list.component.html',
  styleUrls: ['./proposal-list.component.css'],
  providers: [ProposalService]
})

export class ProposalListComponent implements OnInit{
  pageTitle:string = "Proposal List"
  mode = "Observable";
  errorMessage: string;
  proposals: Proposal[];

  constructor(
    private proposalService: ProposalService,
    private router: Router
  ){}

  ngOnInit() {
    let timer = Observable.timer(0,5000);
    timer.subscribe(()=>this.getProposals());
  }

  getProposals(){
    this.proposalService.getProposals()
        .subscribe(
          proposals => this.proposals = proposals,
          error => this.errorMessage = <any>error
        )
  }

  goToShow(proposal: Proposal): void {
    let link = ['/proposal',proposal.id];
    this.router.navigate(link);
  }

}
